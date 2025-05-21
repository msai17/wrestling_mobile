import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/presentation/main/widgets/wrestling_news_card.dart';

class FavoritesNewsCarousel extends StatelessWidget {

  final List<News> newsList;

  const FavoritesNewsCarousel({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: newsList.isNotEmpty ? ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(), // Измените эту строку
        itemCount: newsList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return WrestlingNewsCard(
            onPressed: (News news) {
              GoRouter.of(context).pushNamed(AppRoute.fullNews, extra: news);
            },
            news: newsList[index],
          );
        }, separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      ) : SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height / 1.5,
          child:
          Text('У вас нет избранных новостей', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ),
      ),
    );
  }

}