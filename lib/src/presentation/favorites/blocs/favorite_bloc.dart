import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_favorite_news_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:wrestling_hub/src/domain/video/usecases/get_favorite_videos_usecase.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteNewsUseCase _getFavoriteNewsUseCase;
  final GetFavoriteVideosUseCase _getFavoriteVideosUseCase;


  FavoriteBloc(
      this._getFavoriteNewsUseCase,
      this._getFavoriteVideosUseCase,
      ) : super(FavoriteInitial()) {
    on<FavoriteGetEvent>(_onGetFavorites);
  }


  _onGetFavorites(FavoriteGetEvent event, Emitter<FavoriteState> emit) async {

    final dataStateNews = await _getFavoriteNewsUseCase();
    final dataStateVideos = await _getFavoriteVideosUseCase();

    emit(FavoriteLoadedState(news: dataStateNews.data, videos: dataStateVideos));


  }


}