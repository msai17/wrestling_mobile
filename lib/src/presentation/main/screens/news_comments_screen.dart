import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/utils/wrestling_snackbar.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/error_page.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_form_field.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_comments/news_comment_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/widgets/comment_widget.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_progress_bar.dart';
class NewsCommentsScreen extends StatefulWidget {

  final String idNews;

  const NewsCommentsScreen({super.key, required this.idNews});

  @override
  State<StatefulWidget> createState() => _NewsCommentsScreen();
}

class _NewsCommentsScreen extends State<NewsCommentsScreen> {

  TextEditingController commentFormController = TextEditingController();
  ScrollController scrollController = ScrollController();


  @override
  void initState() {
    context.read<NewsCommentBloc>().add(NewsCommentFetchEvent( widget.idNews));
    super.initState();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(const Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  @override
  void dispose() {
    commentFormController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
         centerTitle: true,
         title: Text('Комментарии',style: Theme.of(context).textTheme.titleLarge),
       ),
        body: BlocConsumer<NewsCommentBloc, NewsCommentState>(
         builder: (context, state) {
           if(state is NewsCommentLoadingState) {
             return const Center(
               child: WrestlingProgressBar(),
             );
           }
           if(state is NewsCommentFailureState){
             return SizedBox(
               child: ErrorPage(
                 errorText: state.message,
                 icon: Icons.error_outline_sharp,
                 buttonText: 'Повторить',
                 onPress: () {
                   context.read<NewsCommentBloc>().add(NewsCommentFetchEvent(widget.idNews));
                   },
               ),
             );
           }
           if(state is NewsCommentLoadedState) {
             return SingleChildScrollView(
               controller: scrollController,
               child: state.comments.isNotEmpty ? Column(
                 children: [
                   ListView.builder(
                       itemCount: state.comments.length,
                       shrinkWrap: true,
                       scrollDirection: Axis.vertical,
                       padding: EdgeInsets.zero,
                       physics: const ScrollPhysics(),
                       itemBuilder: (context, i) {
                         return CommentWidget(comment: state.comments[i]);
                       }
                   ),
                   const SizedBox(height: 60),
                 ],
               ) : const Center(child: Text('Нет комментариев')),
             );
           }
         return ErrorPage(
             errorText: 'УПС',
             buttonText: '',
             onPress: () {
               context.read<NewsCommentBloc>().add(NewsCommentFetchEvent(widget.idNews));
               },
             icon: Icons.question_mark_outlined
           );
           },
         listener: (context, state) {
           if(state is NewsCommentFailureState) {
             WrestlingSnackBar().show(context, "Не удалось отправить комментарий");
           }
           if(state is NewsCommentSendSuccessState) {
             commentFormController.clear();
             _scrollToBottom();
           }
         }
         ),
        bottomSheet: Container(
          height: 55,
          color: AppColors.colorBottomNav,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              Container(
                height: 40,
                width: size.width - 70,
                alignment: Alignment.center,
                child: WrestlingFormField(
                  controller: commentFormController,
                  hintText: 'Комментарий',
                  onChanged: (val) {
                    },
                  inputType: TextInputType.text,
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                icon: const Icon(Icons.send, color: AppColors.colorRed),
                onPressed: () {
                  context.read<NewsCommentBloc>().add(NewsCommentSendEvent(commentFormController.text,widget.idNews,context));
                  },
              ),
            ],
          ),
        )
      ),
    );
  }
}