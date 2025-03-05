import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/services/firebase/firebase_service.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_main_usecase.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, NewsState> {

  final Logger _logger;
  final GetMainUseCase _getMainUseCase;
  final FirebaseService _firebaseService;

  List<News> newsList = [];
  bool isLoadingMore = true;
  bool isLastPage = false;
  int page = 0;



  MainBloc(
      this._getMainUseCase,
      this._logger,
      this._firebaseService,
      ) : super(InitMainState()) {
    on<NewsFetchEvent>(_fetchNewsInit);
    on<NewsLoadMoreEvent>(_fetchNewsLoadMore);
  }

  _fetchNewsInit(NewsFetchEvent event, Emitter<NewsState> emit) async {
    emit(MainLoadingState());
    final dataStateMain = await _getMainUseCase(params: page.toString());
    if (dataStateMain is DataFailed) {
      _logger.e(dataStateMain.error);
      emit(MainErrorState(error: dataStateMain.error.toString()));
    }

    if (dataStateMain is DataSuccess) {
      newsList = dataStateMain.data!.news!;
      emit(MainLoadedState(news: newsList,topNewsHeadlines: dataStateMain.data!.newsTopHeadlines));
      _firebaseService.initNotification();

    }
  }

  _fetchNewsLoadMore(NewsLoadMoreEvent event, Emitter<NewsState> emit) async {
    if(!isLastPage) {
      page++;
    }
    final dataStateMain = await _getMainUseCase(params: page.toString());
    if(dataStateMain is DataFailed) {
      emit(MainErrorState(error: "${dataStateMain.error}"));
      return;
    }
    if(dataStateMain.data!.news!.isEmpty) {
      isLastPage = true;
      emit(MainLoadedState(news: newsList,topNewsHeadlines: dataStateMain.data!.newsTopHeadlines));
      return;
    }
    newsList.addAll(dataStateMain.data!.news!);
    emit(MainLoadedState(news: newsList,topNewsHeadlines: dataStateMain.data!.newsTopHeadlines));
  }
}
