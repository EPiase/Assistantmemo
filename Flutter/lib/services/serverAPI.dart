import 'dart:async';
import 'dart:io';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http_parser/http_parser.dart';
import 'package:assistantmemo/services/models.dart';
import 'package:assistantmemo/services/auth.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Reads all documments from the notes collection
  Future<List<Note>> listNotes() async {
    String UID = await AuthService().getUID();
    var ref = _db.collection('users').doc(UID).collection('notes');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var notes = data.map((d) => Note.fromJson(d));
    return notes.toList();
  }

  /// Retrieves a single note document
  Future<Note> getNote(String noteID) async {
    String UID = await AuthService().getUID();
    var ref = _db.collection('users').doc(UID).collection('notes').doc(noteID);
    var snapshot = await ref.get();
    return Note.fromJson(snapshot.data() ?? {});
  }

  updateClassification(String noteID, String newClass) async {
    String UID = await AuthService().getUID();
    var ref = _db.collection('users').doc(UID).collection('notes').doc(noteID);
    ref.update({'classification': '$newClass'});
  }
}

Future<void> createNoteFromPath(String path) async {
  String UID = await AuthService().getUID();
  print("path is $path");
  await FFmpegKit.executeAsync('-i $path -f flac $path.flac', (session) async {
    final returnCode = await session.getReturnCode();

    if (ReturnCode.isSuccess(returnCode)) {
      // SUCCESS
      print("The return code is: $returnCode");
      print("before");
      print(await session.getState());
      print("after");
      var uri = Uri.parse(
          'https://assistantmemo-u4oydnyd5q-uc.a.run.app/create-note/?user_id=$UID');
      // final response = await http.get(url);
      var request = http.MultipartRequest('PUT', uri)
        ..files.add(await http.MultipartFile.fromPath('file', '$path.flac',
            contentType: MediaType('audio', 'flac')));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // return response.body;
        // return 'success';
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load request');
      }
    } else if (ReturnCode.isCancel(returnCode)) {
      // CANCEL
      print("Cancel $returnCode");
    } else {
      // ERROR
      print("Error: $returnCode");
    }
  });
}

deleteNote(String noteID) async {
  String UID = await AuthService().getUID();
  var url = Uri.parse(
      'https://assistantmemo-u4oydnyd5q-uc.a.run.app/delete-note?user_id=$UID&note_id=$noteID');
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return response.body;
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

Future<String> downloadRecording(String sblob) async {
  final request = await HttpClient().getUrl(Uri.parse(
      'https://assistantmemo-u4oydnyd5q-uc.a.run.app/download_recording?sblob=$sblob'));
  final response = await request.close();
  await response
      .pipe(File('/data/user/0/com.assistantmemo/cache/$sblob').openWrite());
  return '/data/user/0/com.assistantmemo/cache/$sblob';
}
