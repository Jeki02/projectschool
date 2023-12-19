import 'package:flutter_school/Data/Models/Model_News.dart';
import 'package:flutter_school/Data/Repository/Repository_News.dart';

class GetNewsUseCase {
  final NewsApi api;

  GetNewsUseCase(this.api);

  Future<List<News>> call() async {
    return await api.getNews();
  }
}