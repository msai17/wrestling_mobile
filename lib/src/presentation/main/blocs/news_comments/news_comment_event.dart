part of 'news_comment_bloc.dart';

abstract class NewsCommentEvent {

}

final class NewsCommentFetchEvent extends NewsCommentEvent {
  final String id;

  NewsCommentFetchEvent(this.id);
}

final class NewsCommentSendEvent extends NewsCommentEvent {
  final BuildContext context;
  final String newsId;
  final String text;
  NewsCommentSendEvent(this.text,this.newsId, this.context);
}
