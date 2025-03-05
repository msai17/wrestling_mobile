import 'package:flutter/material.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/presentation/video/widgets/video_preview_widget.dart';

class FavoritesVideosCarousel extends StatelessWidget {

  final List<Video> videos;

  const FavoritesVideosCarousel({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: videos.isNotEmpty ? ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(), // Измените эту строку
        itemCount: videos.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return VideoPreviewWidget(
            video: videos[index],
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
          Text('У вас нет избранных видео', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ),
      ),
    );
  }

}