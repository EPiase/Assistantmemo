import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Note {
  String audio_filename;
  String classification;
  DateTime date_recorded;
  bool is_starred;
  String text_transcript;

  Note(
      {this.audio_filename = '',
      this.classification = '',
      DateTime? date_recorded,
      this.is_starred = false,
      this.text_transcript = ''})
      : this.date_recorded = date_recorded ??
            DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true);
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
