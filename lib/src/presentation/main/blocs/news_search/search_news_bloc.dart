import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_search_news_usecase.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_search/search_news_event.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_search/search_news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class SearchNewsBloc extends Bloc<SearchNewsEvent, SearchNewsState> {

  final Logger _logger;
  final GetSearchNewsUseCase _getSearchNewsUseCase;

  List<News> newsList = [];
  bool isLoadingMore = true;
  bool isLastPage = false;
  int page = 0;

  SearchNewsBloc(
      this._getSearchNewsUseCase,
      this._logger,
      ) : super(SearchNewsInitState()) {
    on<SearchNewsFetchEvent>(_onSearchNews);
    on<SearchNewsMoreEvent>(_onSearchLoadMoreNews);
  }

  _onSearchNews(SearchNewsFetchEvent event, Emitter<SearchNewsState> emit) async {
    emit(SearchNewsLoadingState());
    page = 0;
    isLastPage = false;

    Map<String,String> data = {
      'query':event.query,
      'page': "0",
    };
    final dataStateMain = await _getSearchNewsUseCase(params: data);


    if(dataStateMain.data!.length <= 15) {
      isLastPage = true;
    }

    if (dataStateMain is DataFailed) {
      _logger.e(dataStateMain.error);
      emit(SearchNewsErrorState(error: dataStateMain.error.toString()));
    }

    if (dataStateMain is DataSuccess) {
      if(dataStateMain.data!.isEmpty) {
        emit(SearchNewsEmptyState());
      }else{
        newsList = dataStateMain.data!;
        emit(SearchNewsSuccessState(news: newsList));
      }
    }
  }

  _onSearchLoadMoreNews(SearchNewsMoreEvent event, Emitter<SearchNewsState> emit) async {
    isLastPage = false;
    if(!isLastPage) {
      page++;
    }

    Map<String,String> data = {
      'query':event.query,
      'page':page.toString(),
    };


    final dataStateMain = await _getSearchNewsUseCase(params:data);

    if (dataStateMain is DataFailed) {
      _logger.e(dataStateMain.error);
      emit(SearchNewsErrorState(error: dataStateMain.error.toString()));
    }

    if(dataStateMain.data!.isEmpty) {
      isLastPage = true;
      emit(SearchNewsSuccessState(news: newsList));
      return;
    }

    if (dataStateMain is DataSuccess) {
      newsList.addAll(dataStateMain.data!);
      emit(SearchNewsSuccessState(news: newsList));
    }



  }

}
