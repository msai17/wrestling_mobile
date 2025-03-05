import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/domain/video/usecases/add_video_usecase.dart';
import 'package:wrestling_hub/src/domain/video/usecases/delete_video_usecase.dart';
import 'package:wrestling_hub/src/domain/video/usecases/is_favorite_video_usecase.dart';


class VideoFavoriteCubit extends Cubit<Set<int>> {
  final AddFavoriteVideoUseCase _addFavoriteVideoUseCase;
  final DeleteFavoriteVideoUseCase _deleteFavoriteVideoUseCase;
  final IsFavoriteVideoUseCase _isFavoriteVideoUseCase;

  VideoFavoriteCubit(
      this._isFavoriteVideoUseCase,
      this._addFavoriteVideoUseCase,
      this._deleteFavoriteVideoUseCase
      ) : super({});


  Future<void> toggleFavorite(Video video) async {
    bool isFav = await _isFavoriteVideoUseCase(params: video);
    final newFavorites = Set<int>.from(state);

    if (isFav) {
      await _deleteFavoriteVideoUseCase(params: video);
      newFavorites.remove(int.parse(video.id.toString()));
    } else {
      await _addFavoriteVideoUseCase(params: video);
      newFavorites.add(int.parse(video.id.toString()));
    }

    emit(newFavorites);
  }


  Future<void> loadFavorites(Video video) async {
    bool isFav = await _isFavoriteVideoUseCase(params: video);
    final newFavorites = Set<int>.from(state);

    if (isFav) {
      newFavorites.add(int.parse(video.id.toString()));
    } else {
      newFavorites.remove(int.parse(video.id.toString()));
    }

    emit(newFavorites);
  }

}
