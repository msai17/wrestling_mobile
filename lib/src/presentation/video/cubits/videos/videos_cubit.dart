import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/domain/main/usecases/add_favorite_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/delete_favorite_news_usecase.dart';
import 'package:wrestling_hub/src/domain/video/usecases/get_favorite_videos_usecase.dart';
import 'package:wrestling_hub/src/domain/video/usecases/get_videos_usecase.dart';
import 'package:wrestling_hub/src/domain/video/usecases/is_favorite_video_usecase.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/videos/videos_state.dart';
import 'package:wrestling_hub/src/presentation/video/widgets/videos_carousel.dart';

import '../../../../../core/resources/data_state.dart';

class VideosCubit extends Cubit<VideosState> {
  final Logger _logger;
  final GetVideosUseCase _getVideosUseCase;

  VideosCubit(
      this._logger,
      this._getVideosUseCase,
      ) : super(VideosInitState());

  Future<void> onGetVideos(bool isRefresh) async {
    if(!isRefresh) {
      emit(VideosLoadingState());
    }

    final dataState = await _getVideosUseCase();

    if (dataState is DataFailed) {
      _logger.e(dataState.error);
      return emit(VideosFailureState(message: dataState.error.toString()));
    }

    if (dataState.data!.isEmpty) {
      return emit(VideosFailureState(message: 'Пусто'));
    }

    if (dataState is DataSuccess) {
      final List<Widget> tabs = [];
      final List<Widget> pages = [];

      for (var action in dataState.data!) {
          tabs.add(Tab(text: action.name));
          pages.add(VideosCarousel(videos: action.videos!));
      }

      return emit(VideosSuccessState(isRefresh,tabs: tabs ,pages: pages ));
    }
  }
}