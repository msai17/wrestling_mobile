import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/core/utils/wrestling_time_stamp.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/show_image.dart';

class WrestlingNewsTopCard extends StatelessWidget {

  final News news;

  const WrestlingNewsTopCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme;
    final widgetSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: widgetSize.width * 0.95,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          GoRouter.of(context).pushNamed(AppRoute.fullNews, extra: news);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowImage(image: news.images!.split(',').first, width: double.infinity,height: 250, circular: 5,opacity: .5,isCard: true),
            SizedBox(
              child: Text(
                '${news.title}\n',
                style: txtStyle.bodyLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Text(
              WrestlingTimeStamp.timeAgo(news.creationDateTime.toString()),
              style: txtStyle.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );

  }



}