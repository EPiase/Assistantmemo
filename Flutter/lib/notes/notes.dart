import 'package:flutter/material.dart';
import 'package:assistantmemo/services/auth.dart';
import 'package:assistantmemo/shared/BottomNavBar.dart';
import 'package:assistantmemo/services/serverAPI.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: showID(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class showID extends StatefulWidget {
  const showID({Key? key}) : super(key: key);

  @override
  _showIDState createState() => _showIDState();
}

class _showIDState extends State<showID> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: AuthService().getUID(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('error');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          String uid = snapshot.data.toString();
          return Text("current user: $uid");
          // return Text(snapshot.data.toString());
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Text('loading', textDirection: TextDirection.ltr);
      },
    );
  }
}
// class showID extends StatelessWidget {
//   const showID({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: AuthService().userStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // return const LoadingScreen();
//             return const Text('loading');
//           } else if (snapshot.hasError) {
//             return const Center(
//               child: Text('error'),
//               // child: ErrorMessage(),
//             );
//           } else if (snapshot.hasData) {
//             // return const TopicsScreen();
//             // String userData = snapshot.data.toString();
//             // return Center(child: Text(snapshot.data.toString()));
//             return Text(AuthService().getUID());
//           } else {
//             return const Center(
//               child: Text('error'),
//               // child: ErrorMessage(),
//             );
//           }
//         });
//   }
// }
