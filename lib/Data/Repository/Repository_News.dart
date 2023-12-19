import 'package:dio/dio.dart';
import 'package:flutter_school/Data/Models/Model_News.dart';
import 'package:retrofit/retrofit.dart';

part 'Repository_News.g.dart';

@RestApi(baseUrl: "https://school-9845c-default-rtdb.firebaseio.com/")
abstract class NewsApi {
  factory NewsApi(Dio dio, {String baseUrl}) = _NewsApi;

  @GET("/school.json")
  Future<List<News>> getNews();
}