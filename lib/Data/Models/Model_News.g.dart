// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Model_News.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      topic: json['topic'] as String,
      title: json['title'] as String,
      photo_path: json['photo_path'] as String,
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'topic': instance.topic,
      'title': instance.title,
      'photo_path': instance.photo_path,
    };
