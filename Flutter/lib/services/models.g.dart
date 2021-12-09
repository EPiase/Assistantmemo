// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      json['note_id'] as String,
      DateTime.parse(json['date_recorded'] as String),
      audio_filename: json['audio_filename'] as String? ?? '',
      classification: json['classification'] as String? ?? 'Short Note',
      is_starred: json['is_starred'] as bool? ?? false,
      text_transcript: json['text_transcript'] as String? ?? '',
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'note_id': instance.note_id,
      'audio_filename': instance.audio_filename,
      'classification': instance.classification,
      'date_recorded': instance.date_recorded.toIso8601String(),
      'is_starred': instance.is_starred,
      'text_transcript': instance.text_transcript,
    };
