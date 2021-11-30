import 'package:flutter/material.dart';
import 'package:assistantmemo/services/auth.dart';
import 'package:assistantmemo/shared/BottomNavBar';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
