// import 'dart:js';

import 'package:assistantmemo/home/homepage.dart';
import 'package:assistantmemo/login/login.dart';
import 'package:assistantmemo/notes/notes.dart';
import 'package:assistantmemo/record/record.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  'login': (context) => const LoginScreen(),
  'record': (context) => const RecordScreen(),
  'notes': (context) => const NotesScreen(),
};
