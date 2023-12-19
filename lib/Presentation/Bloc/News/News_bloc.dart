import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_school/Domain/UseCase/UseCase_News.dart';
import 'package:flutter_school/Presentation/Bloc/News/News_event.dart';
import 'package:flutter_school/Presentation/Bloc/News/News_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase;

  NewsBloc(this.getNewsUseCase) : super(NewsInitial()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await getNewsUseCase();
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}