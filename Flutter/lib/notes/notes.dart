import 'package:assistantmemo/services/models.dart';
import 'package:flutter/material.dart';
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
    return FutureBuilder<Note>(
      // Initialize FlutterFire:
      future: getNote('f819467a-d9bc-4388-bc34-74210aa30a80'),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text('error');
        } else if (snapshot.hasData) {
          var note = snapshot.data!;
          return Text(note.text_transcript);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('loading', textDirection: TextDirection.ltr);
        } else {
          return Text(
              "Really strange error, there might be missing data in DB");
        }
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
