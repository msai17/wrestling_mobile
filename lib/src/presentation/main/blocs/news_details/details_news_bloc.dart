import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/domain/main/usecases/add_favorite_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/check_favorite_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/delete_favorite_news_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_full_news_usecase.dart';
import 'details_news_event.dart';
import 'details_news_state.dart';


class DetailsNewsBloc extends Bloc<DetailsNewsEvent, DetailsNewsState> {

  final Logger _logger;
  final GetFullNewsUseCase _getFullNewsUseCase;
  final AddFavoriteNewsUseCase _addFavoriteNewsUseCase;
  final DeleteFavoriteNewsUseCase _deleteFavoriteNewsUseCase;
  final CheckFavoriteNewsUseCase _checkFavoriteNewsUseCase;


  News? fullNews;

  DetailsNewsBloc(
      this._getFullNewsUseCase,
      this._addFavoriteNewsUseCase,
      this._deleteFavoriteNewsUseCase,
      this._checkFavoriteNewsUseCase,
      this._logger,
      ) : super(DetailsNewsInitState()) {
    on<DetailsNewsFetchEvent>(_onFullNews);
    on<DetailNewsAddFavoriteEvent>(_onAddFavorite);
    on<DetailNewsDeleteFavoriteEvent>(_onDeleteFavorite);
  }

  _onFullNews(DetailsNewsFetchEvent event, Emitter<DetailsNewsState> emit) async {
    emit(DetailsNewsLoadingState());

    await Future.delayed(const Duration(milliseconds: 200));
    final dataStateMain = await _getFullNewsUseCase(params: event.news.id.toString());
    final dataFavorite = await _checkFavoriteNewsUseCase(params: event.news);

    if (dataStateMain is DataFailed) {
      _logger.e(dataStateMain.error);
      emit(DetailsNewsErrorState(error: dataStateMain.error.toString()));
    }

    if (dataStateMain is DataSuccess) {
      fullNews = dataStateMain.data;
      emit(DetailsNewsSuccessState(full: fullNews, isFavorite: dataFavorite.data!));
    }
  }

  _onAddFavorite(DetailNewsAddFavoriteEvent event, Emitter<DetailsNewsState> emit) async {
    await _addFavoriteNewsUseCase(params: event.data);
    final dataFavorite = await _checkFavoriteNewsUseCase(params: event.data);
    emit(DetailsNewsSuccessState(full: fullNews, isFavorite: dataFavorite.data!));
  }

  _onDeleteFavorite(DetailNewsDeleteFavoriteEvent event, Emitter<DetailsNewsState> emit) async {
    await _deleteFavoriteNewsUseCase(params: event.data.id);
    final dataFavorite = await _checkFavoriteNewsUseCase(params: event.data);
    emit(DetailsNewsSuccessState(full: fullNews, isFavorite: dataFavorite.data!));
  }

}
