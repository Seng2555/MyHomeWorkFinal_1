import 'package:flutter/material.dart';
import 'package:flutter_firebase_homework1/models/people_model.dart';
import 'package:flutter_firebase_homework1/pages/create_people.dart';
import 'package:flutter_firebase_homework1/pages/detail_people_page.dart';
import 'package:flutter_firebase_homework1/services/people_service.dart';

import '../services/google_signin_service.dart';

class ShowPeoplePage extends StatelessWidget {
  const ShowPeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People List'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //await FirebaseAuth.instance.signOut();
              GoogleSigninService().logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<PeopleModel>>(
        stream: PeopleService().getPeople(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              var data = snapshot.data![index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPeoplePage(people: data),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    data.photo ??
                        'https://3znvnpy5ek52a26m01me9p1t-wpengine.netdna-ssl.com/wp-content/uploads/2017/07/noimage_person.png',
                  ),
                ),
                title: Text(data.name!),
                subtitle: Text(data.email!),
                trailing: Text(data.gender!),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: snapshot.data!.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePeoplePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
