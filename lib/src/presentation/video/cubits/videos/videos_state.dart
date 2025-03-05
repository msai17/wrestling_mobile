import 'package:flutter/cupertino.dart';
import 'package:wrestling_hub/src/data/video/models/category_video.dart';

abstract class VideosState {}

class VideosInitState extends VideosState {
  VideosInitState();
}
class VideosLoadingState extends VideosState {
  VideosLoadingState();
}
class VideosFailureState extends VideosState {
  final String message;
  VideosFailureState({required this.message});
}
class VideosSuccessState extends VideosState {
  final List<Widget> tabs;
  final List<Widget> pages;
  final bool isRefresh;

  VideosSuccessState(this.isRefresh, {required this.tabs,required this.pages});
}