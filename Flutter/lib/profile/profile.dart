import 'package:flutter/material.dart';
import 'package:assistantmemo/services/auth.dart';
import 'package:assistantmemo/shared/BottomNavBar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ElevatedButton(
          child: Text('signout'),
          onPressed: () async {
            await AuthService().signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
