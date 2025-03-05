import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/presentation/video/widgets/video_preview_widget.dart';

class VideosCarousel extends StatelessWidget {

  final List<Video> videos;

  const VideosCarousel({super.key, required this.videos});

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
            Text('В данной категории еще не\n добавили видео', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ),
      ),
    );
  }

}