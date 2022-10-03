import 'package:flutter/material.dart';
import 'package:flutter_firebase_homework1/services/google_signin_service.dart';

class GoogleSigninPage extends StatefulWidget {
  const GoogleSigninPage({Key? key}) : super(key: key);

  @override
  State<GoogleSigninPage> createState() => _GoogleSigninPageState();
}

class _GoogleSigninPageState extends State<GoogleSigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Signin'),
        centerTitle: true,
      ),
      body: Center(
        child: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          icon: SizedBox(
            height: 45.0,
            width: 45.0,
            child: Image.asset('assets/icons/google-logo.png'),
          ),
          onPressed: () {
            GoogleSigninService().siginWithGoogle();
            setState(() {});
          },
          label: Text(
            'Signin with Google',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
