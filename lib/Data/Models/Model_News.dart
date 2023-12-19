import 'package:json_annotation/json_annotation.dart';

part 'Model_News.g.dart';

@JsonSerializable()
class News {
  final String topic;
  final String title;
  final String photo_path;

  News({required this.topic,required this.title, required this.photo_path});

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}