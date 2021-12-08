import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Note {
  String audio_filename;
  String classification;
  final DateTime date_recorded;
  bool is_starred;
  String text_transcript;

  Note(this.date_recorded,
      {this.audio_filename = '',
      this.classification = '',
      this.is_starred = false,
      this.text_transcript = ''});
  // factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  factory Note.fromJson(Map<String, dynamic> json) {
    json["date_recorded"] =
        ((json["date_recorded"] as Timestamp).toDate().toString());
    return _$NoteFromJson(json);
  }
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
