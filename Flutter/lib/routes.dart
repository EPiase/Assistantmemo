import 'package:assistantmemo/home/homepage.dart';
import 'package:assistantmemo/login/login.dart';
import 'package:assistantmemo/notes/notes.dart';
import 'package:assistantmemo/record/record.dart';
import 'package:assistantmemo/profile/profile.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/Record': (context) => RecordingSlide(),
  // '/Record': (context) => const AudioRecorder(),
  '/Notes': (context) => const NotesScreen(),
  '/Profile': (context) => const ProfileScreen(),
};
