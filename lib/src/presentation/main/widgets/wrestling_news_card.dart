import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/utils/wrestling_time_stamp.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/show_image.dart';

class WrestlingNewsCard extends StatelessWidget {

  final News news;
  final ValueChanged<News> onPressed;
  const WrestlingNewsCard({super.key, required this.news,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        return onPressed(news);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 240,
                  child: Text(
                    '${news.title}',
                    style: txtStyle.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                Text(
                  WrestlingTimeStamp.timeAgo(news.creationDateTime.toString()),
                  style: txtStyle.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            ShowImage(image: news.images!.split(',').first, width: 100,height: 80, circular: 5,opacity: .5,isCard: true),
          ],
        ),
      ),
    );

  }



}