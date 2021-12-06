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

main() async {
  // String futureResponse = await createNoteFromPath();
  print(await createNoteFromPath(
      '/home/alex/Assistantmemo/Flutter/assets/untitled.flac',
      'lTcVQBFclld6JkQZ2R6WKTWu7fB2'));
}
