import 'package:agrozon/AppConstants/AppString.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agrozon/Core/AuthBase.dart';
import 'LandingPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth firebaseAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppString.appName),
        actions: [
          TextButton(
              onPressed: () async {
                bool canLogout = await Auth.signOut();
                if (canLogout) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                      (route) => false);
                }
              },
              child: Text('Logout'))
        ],
      ),
      body: Container(
        child: Text('logged in user is'),
      ),
    );
  }
}
