import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_homework1/services/google_signin_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              //await FirebaseAuth.instance.signOut();
              GoogleSigninService().logout();
              setState(() {});
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                user!.photoURL ??
                    'https://www.kbbioenergy.com/wp-content/uploads/2020/04/no-image.jpg',
              ),
            ),
            Text(
              user.displayName ?? 'DisplayName',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              user.email ?? 'Email',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
