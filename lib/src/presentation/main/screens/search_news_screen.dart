import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_search/search_news_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_search/search_news_event.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_search/search_news_state.dart';
import 'package:wrestling_hub/src/presentation/main/widgets/wrestling_news_card.dart';
import 'package:wrestling_hub/src/presentation/main/widgets/wrestling_search_widget.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_progress_bar.dart';
class SearchNewsScreen extends StatefulWidget {

  const SearchNewsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchNewsScreen();

}

class _SearchNewsScreen extends State<SearchNewsScreen> {

  TextEditingController txtSearchController = TextEditingController();
  ScrollController newsScrollController = ScrollController();

  var randomWords = ['Угуев','Абасгаджи','Садулаев', 'Сидаков', 'Лев'];


  @override
  void initState() {
    _generateRandomWord();
    context.read<SearchNewsBloc>().add(SearchNewsFetchEvent(txtSearchController.text));
    newsScrollController.addListener(() => _newsScrollListener());
    super.initState();
  }

  _generateRandomWord() {
    randomWords.shuffle(Random(randomWords.length));
    int index = Random().nextInt(randomWords.length);
    var rand = randomWords[index];
    txtSearchController.text = rand;
  }

  _newsScrollListener() {
    if (newsScrollController.position.pixels == newsScrollController.position.maxScrollExtent) {
      context.read<SearchNewsBloc>().add(SearchNewsMoreEvent(txtSearchController.text));
    }
  }

  @override
  void dispose() {
    newsScrollController.dispose();
    txtSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Результаты", style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            children: [
              WrestlingSearchWidget(
                controller: txtSearchController,
                autoShowKeyboard: false,
                onPressSearch: (val) {
                  context.read<SearchNewsBloc>().add(SearchNewsFetchEvent(val));
                },
              ),
              Expanded(
                child: BlocBuilder<SearchNewsBloc, SearchNewsState>(
                  builder: (BuildContext context, SearchNewsState state) {
                   if (state is SearchNewsLoadingState) {
                     return const Center(child:  WrestlingProgressBar());
                   }
                   if(state is SearchNewsEmptyState) {
                     return Center(child: Text('Результаты по вашему поиску не найдено', style: Theme.of(context).textTheme.titleMedium));
                   }
                   if (state is SearchNewsSuccessState) {
                     final news = state.news;
                     return ListView.builder(
                         shrinkWrap: true,
                         controller: newsScrollController,
                         physics: const ScrollPhysics(),
                         itemCount: context.read<SearchNewsBloc>().isLoadingMore ? news.length + 1 : news.length,
                         scrollDirection: Axis.vertical,
                         padding: EdgeInsets.zero,
                         itemBuilder: (context, index) {
                           if (index >= news.length) {
                             return Center(child: context.read<SearchNewsBloc>().isLastPage ? Text('Вы загрузили максимальное количество новостей', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,)
                                 : const WrestlingProgressBar());
                           } else {
                             return WrestlingNewsCard(news: news[index], onPressed: (News value) {
                               GoRouter.of(context).pushNamed(AppRoute.fullNews, extra: news[index]);
                             },
                             );
                        }
                     }
                     );
                   }
                   if (state is SearchNewsErrorState) {
                     return Center(child: Text(state.error, style: Theme.of(context).textTheme.titleMedium));
                   }
                   return Center(child: Text('Упс. Что-то пошло не так', style: Theme.of(context).textTheme.titleMedium));
                  }
                ),
              ),
            ],
          ),
      ),
    );
  }
}