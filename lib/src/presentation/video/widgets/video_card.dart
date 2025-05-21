import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/core/utils/wrestling_copy_clipboard.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/show_image.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/video_cubit/video_favorite_cubit.dart';


class VideoCard extends StatelessWidget {

  final Video video;

  const VideoCard({super.key, required this.video});


  String getImageUrl(Video video) {
    if(video.urlPreview!.isEmpty || !video.urlPreview!.startsWith('http')) {
      if(video.type == 'vk') {
         return 'https://www.sostav.ru/images/news/2021/10/15/nlmb6mfz_md.png';
      }
      if(video.type == 'youtube') {
        return 'https://t3.ftcdn.net/jpg/06/52/91/76/240_F_652917684_YQQ1zh1IvFAxLp1RZDL5KgzxpOebyMrx.jpg';
      }
    }
    return video.urlPreview.toString();
  }

  
  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    return SizedBox(
      child: InkWell(
        onTap: () {
          GoRouter.of(context).pushNamed(AppRoute.vk_video, extra: video);
        },
        child: Column(
          children: [
            const Icon(Icons.play_circle,color: AppColors.colorRed,size: 120),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: ShowImage(image: video.urlPreview, height: 50, width: 50, circular: 90,isCard: true),
                ),
                const SizedBox(width: 10),
                Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widgetSize.width * 0.65,
                      child: Text(video.name.toString(),style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Crimson', fontSize: 14),maxLines: 2,overflow: TextOverflow.ellipsis,)
                    ),
                    SizedBox(
                        width: widgetSize.width * 0.65,
                        child: Text(video.description.toString(),style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.bold, fontFamily: 'Crimson', fontSize: 13),maxLines: 2),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    children: [
                      BlocBuilder<VideoFavoriteCubit, Set<int>>(
                        builder: (context, favorites) {
                          bool isFavorite = favorites.contains(int.parse(video.id.toString()));
                          return InkWell(
                            onTap: () {
                              context.read<VideoFavoriteCubit>().toggleFavorite(video);
                            },
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      PopupMenuButton(
                        icon: const Icon(Icons.more_vert_rounded,color: Colors.white),
                        color: Colors.black,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () async {
                                await launchUrl(Uri.parse(video.urlVideo.toString()), mode: LaunchMode.externalApplication);
                              },
                              child:Text('Посмотреть ВК Видео',style: Theme.of(context).textTheme.labelSmall)
                          ),
                          PopupMenuItem(
                              onTap: () {
                                  CopyClipBoard().copy(video.urlVideo.toString(), "Ссылка скопировано");
                              },
                              child:Text('Скопировать ссылку',style: Theme.of(context).textTheme.labelSmall)
                          ),
                          PopupMenuItem(
                              onTap: ()  {
                                GoRouter.of(context).push(AppRoute.vk_video_info);
                              },
                              child:Text('Нашли свое видео ?',style: Theme.of(context).textTheme.labelSmall)
                          ),
                          PopupMenuItem(
                              onTap: () async {
                                await Share.share('${ video.name}\nссылка: ${ video.urlVideo}\nСкачать мобильное приложение\nIOS: ${AppUrls.appStore}\nAndroid:  ${AppUrls.googlePlay}');
                              },
                              child:Text('Поделиться',style: Theme.of(context).textTheme.labelSmall)
                          ),
                        ],
                      ),
                    ],
                  )
                )
              ],
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  
  
  
}