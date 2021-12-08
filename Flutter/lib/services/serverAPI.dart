import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http_parser/http_parser.dart';
import 'package:assistantmemo/services/models.dart';
import 'package:assistantmemo/services/auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Reads all documments from the topics collection
  Future<List<Note>> getTopics() async {
    String UID = await AuthService().getUID();
    var ref = _db.collection('users').doc(UID).collection('notes');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var notes = data.map((d) => Note.fromJson(d));
    return notes.toList();
  }

  /// Retrieves a single quiz document
  Future<Note> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Note.fromJson(snapshot.data() ?? {});
  }
}

Future<String> createNoteFromPath(String path) async {
  String UID = await AuthService().getUID();
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

// TODO
Future<List<Note>> listNotes() async {
  String UID = await AuthService().getUID();
  var url = Uri.parse(
      'https://assistantmemo-u4oydnyd5q-uc.a.run.app/list-notes?user_id=$UID');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["dataKey"];
    List<Note> Notes =
        List<Note>.from(data.map((model) => Note.fromJson(model)));
    return Notes;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load request');
  }
}

// TODO
// Future<Note> getNote(String noteID) async {
//   String UID = await AuthService().getUID();
//   var url = Uri.parse(
//       'https://assistantmemo-u4oydnyd5q-uc.a.run.app/get_note_by_id?user_id=$UID&note_id=$noteID');
//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     final parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
//     return await Note.fromJson(parsed);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load request');
//   }
// }
Future<Note> getNote(String noteID) async {
  String UID = await AuthService().getUID();
  var url = Uri.parse(
      'https://assistantmemo-u4oydnyd5q-uc.a.run.app/get_note_by_id?user_id=$UID&note_id=$noteID');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final parsed = jsonDecode(response.body); //.cast<Map<String, dynamic>>();
    return await Note.fromJson(parsed);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load request');
  }
}

Future<String> deleteNote(String noteID) async {
  String UID = await AuthService().getUID();
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

Future<String> starNote(String noteID, bool starStatus) async {
  String UID = await AuthService().getUID();
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
