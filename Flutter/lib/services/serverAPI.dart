import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<String> createNoteFromPath(String path, String UID) async {
  var uri = Uri.parse(
      'https://assistantmemo-u4oydnyd5q-uc.a.run.app/create-note/?user_id=$UID');
  // final response = await http.get(url);
  var request = http.MultipartRequest('PUT', uri)
    ..files.add(await http.MultipartFile.fromPath('file', path,
        contentType: MediaType('audio', 'flac')));
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return response.body;
    return 'success';
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load request');
  }
}

Future<String> listNotes(String UID) async {
  var url = Uri.parse(
      'https://assistantmemo-u4oydnyd5q-uc.a.run.app/list-notes?user_id=$UID');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load request');
  }
}

Future<String> getNote(String UID, String noteID) async {
  var url = Uri.parse(
      'https://assistantmemo-u4oydnyd5q-uc.a.run.app/get_note_by_id?user_id=$UID&note_id=$noteID');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load request');
  }
}

Future<String> deleteNote(String UID, String noteID) async {
  var url = Uri.parse(
      'https://assistantmemo-u4oydnyd5q-uc.a.run.app/delete-note?user_id=$UID&note_id=$noteID');
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load request');
  }
}

Future<String> starNote(String UID, String noteID, bool starStatus) async {
  var url = Uri.parse(
      'https://assistantmemo-u4oydnyd5q-uc.a.run.app/star-note?user_id=$UID&note_id=$noteID&star_status=$starStatus');
  final response = await http.put(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load request');
  }
}

// main() async {
//   // String futureResponse = await createNoteFromPath();
//   // print(await createNoteFromPath(
//   //     '/home/alex/Assistantmemo/Flutter/assets/untitled.flac',
//   //     'lTcVQBFclld6JkQZ2R6WKTWu7fB2'));
//   // print(await starNote('lTcVQBFclld6JkQZ2R6WKTWu7fB2',
//   //     '20cd6e8d-158b-42ae-88b6-a50a9cd345b8', false));
//   print(await listNotes('lTcVQBFclld6JkQZ2R6WKTWu7fB2'));
//   // print(await getNote(
//   //     'lTcVQBFclld6JkQZ2R6WKTWu7fB2', '20cd6e8d-158b-42ae-88b6-a50a9cd345b8'));
//   print(await deleteNote(
//       'lTcVQBFclld6JkQZ2R6WKTWu7fB2', 'd6378a2e-2b53-492d-b537-59f211015076'));
// }

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<String> futureNotes;

//   @override
//   void initState() {
//     super.initState();
//     futureNotes = listNotes();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<String>(
//             future: futureNotes,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!);
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
