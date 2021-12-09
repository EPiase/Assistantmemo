import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:assistantmemo/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = AuthService().user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tomate'),
          // displayUserInfo(appUser),
          Center(
            child: ElevatedButton(
                child: Text('Sign Out'),
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                }),
          ),
        ],
      ),
    );
  }

  // Text displayUserInfo(User? appUser) => FutureBuilder(builder: appUser.email);
}
