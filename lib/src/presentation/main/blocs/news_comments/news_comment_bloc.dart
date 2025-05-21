import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/data/main/models/comment.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_comments_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/send_news_comment_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/modal_bottom_auth.dart';


part 'news_comment_event.dart';
part 'news_comment_state.dart';

class NewsCommentBloc extends Bloc<NewsCommentEvent, NewsCommentState> {
  final Logger _logger;
  final UserData _userData;
  final GetCommentsNewsUseCase _getCommentsNewsUseCase;
  final SendNewsCommentUseCase  _sendNewsCommentUseCase;

  List<Comment> comments = [];

  NewsCommentBloc(
      this._getCommentsNewsUseCase,
      this._sendNewsCommentUseCase,
      this._logger,
      this._userData,
      ) : super(NewsCommentInitialState()) {
    on<NewsCommentFetchEvent>(_onFetchComments);
    on<NewsCommentSendEvent>(_onSendComment);
  }

  _onFetchComments(NewsCommentFetchEvent event, Emitter<NewsCommentState> emit) async {
    comments.isNotEmpty ? comments.clear() : null;

    emit(NewsCommentLoadingState());
    final dataState = await _getCommentsNewsUseCase(params: event.id.toString());

    if (dataState is DataFailed) {
      _logger.e(dataState.error);
      return emit(NewsCommentFailureState(message: dataState.error.toString()));
    }

    if (dataState is DataSuccess) {
      comments = dataState.data!;
      return emit(NewsCommentLoadedState(comments: dataState.data!));
    }
  }

  _onSendComment(NewsCommentSendEvent event, Emitter<NewsCommentState> emit) async {
    if(event.text.isEmpty) {
      return;
    }

    if(!_userData.isLogged()!) {
      ModalBottomAuth(
          callback: (String val ) {
            if(val.length < 10) {
              Fluttertoast.showToast(msg: 'Пожалуйста введите корректный номер');
            }else{
              GoRouter.of(event.context).pushNamed(AppRoute.sms, pathParameters: {
                'number': val,
              }).then((val) {
                if(val == 'auth') {
                  if(event.context.mounted){
                    NewsCommentSendEvent(event.text,event.newsId,event.context);
                    GoRouter.of(event.context).pop();
                  }
                }
              });
            }
          }).show(event.context);
      return;
    }

    Map<String,String> data = {
      'token': _userData.getAccessToken().toString(),
      'id':event.newsId,
      'text': event.text,
    };

    final dataState = await _sendNewsCommentUseCase(params: data);

    if (dataState is DataFailed) {
      Fluttertoast.showToast(msg: 'Что-то пошло не так');
      if(comments.isNotEmpty) {
        emit(NewsCommentLoadedState(comments: comments));
      }
    }

    if (dataState is DataSuccess) {
      emit(NewsCommentSendSuccessState());
      comments = dataState.data!;
      return emit(NewsCommentLoadedState(comments: comments));
    }
  }

}
