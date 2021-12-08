// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      audio_filename: json['audio_filename'] as String? ?? '',
      classification: json['classification'] as String? ?? '',
      date_recorded: json['date_recorded'] == null
          ? null
          : DateTime.parse(json['date_recorded'] as String),
      is_starred: json['is_starred'] as bool? ?? false,
      text_transcript: json['text_transcript'] as String? ?? '',
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'audio_filename': instance.audio_filename,
      'classification': instance.classification,
      'date_recorded': instance.date_recorded.toIso8601String(),
      'is_starred': instance.is_starred,
      'text_transcript': instance.text_transcript,
    };
