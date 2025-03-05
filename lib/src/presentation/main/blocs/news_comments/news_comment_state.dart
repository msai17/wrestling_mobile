part of 'news_comment_bloc.dart';

abstract class NewsCommentState {}

final class NewsCommentInitialState extends NewsCommentState {

}

final class NewsCommentLoadingState extends NewsCommentState {}

final class NewsCommentSendSuccessState extends NewsCommentState {}


final class NewsCommentLoadedState extends NewsCommentState {
  final List<Comment> comments;
  NewsCommentLoadedState({required this.comments});
}

final class NewsCommentFailureState extends NewsCommentState {
    final String message;
    NewsCommentFailureState({required this.message});
}



