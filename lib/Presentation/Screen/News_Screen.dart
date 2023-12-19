import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_school/Data/Repository/Repository_News.dart';
import 'package:flutter_school/Domain/UseCase/UseCase_News.dart';
import 'package:flutter_school/Presentation/Bloc/News/News_bloc.dart';
import 'package:flutter_school/Presentation/Bloc/News/News_event.dart';
import 'package:flutter_school/Presentation/Bloc/News/News_state.dart';

class NewsScreen extends StatelessWidget {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    final NewsApi newsApi = NewsApi(dio);
    final GetNewsUseCase getNewsUseCase = GetNewsUseCase(newsApi);

    return BlocProvider(
      create: (context) => NewsBloc(getNewsUseCase)..add(LoadNews()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News List'),
        ),
        body: Container(
          color: Colors.blue[100], 
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NewsLoaded) {
                return AnimatedList(
                  key: _listKey,
                  initialItemCount: state.news.length,
                  itemBuilder: (context, index, animation) {
                    final news = state.news[index];
                    return SlideTransition(
                      position: animation.drive(Tween(begin: Offset(1, 0), end: Offset(0, 0)).chain(CurveTween(curve: Curves.easeOut))),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          title: Text(news.title, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(news.topic),
                          leading: news.photo_path.isNotEmpty
                              ? Image.network(news.photo_path, width: 100, fit: BoxFit.cover)
                              : SizedBox(width: 100),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is NewsError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return Center(child: Text('Unknown state'));
              }
            },
          ),
        ),
      ),
    );
  }
}