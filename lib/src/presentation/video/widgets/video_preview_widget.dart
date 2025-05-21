import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/core/utils/wrestling_copy_clipboard.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/show_image.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/video_cubit/video_favorite_cubit.dart';

class VideoPreviewWidget extends StatelessWidget {

  final Video video;


  const VideoPreviewWidget({super.key, required this.video});


  @override
  Widget build(BuildContext context) {
    context.read<VideoFavoriteCubit>().loadFavorites(video);
    final widgetSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushNamed(AppRoute.vk_video, extra: video);
      },
      child: Column(
       children: [
         ShowImage(image: video.urlImage, height: 200, width: double.infinity, circular: 0,isCard: true),
         const SizedBox(height: 5),
         Row(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             ShowImage(image:video.iconSource, height: 40, width: 40, circular: 90,isCard: true),
             const SizedBox(width: 5),
             Column (
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 SizedBox(
                     width: widgetSize.width * 0.62,
                     child: Text(video.name.toString(),style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Crimson', fontSize: 14),maxLines: 2,overflow: TextOverflow.ellipsis,)
                 ),
                 SizedBox(
                   width: widgetSize.width * 0.62,
                   child: Text("${video.source.toString()} • ${video.creationDateTime!.split(' ')[0]}",style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontWeight: FontWeight.bold, fontFamily: 'Crimson', fontSize: 12),maxLines: 2),
                 ),
               ],
             ),
             Expanded(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
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
                   Align(
                     alignment: Alignment.topCenter,
                     child: PopupMenuButton(
                       icon: const Icon(Icons.more_vert_rounded,color: Colors.white),
                       color: Colors.black,
                       itemBuilder: (context) => [
                         PopupMenuItem(
                             onTap: () async {
                               await launchUrl(Uri.parse( video.urlVideo.toString()), mode: LaunchMode.externalApplication);
                               },
                             child:Text('Посмотреть ВК Видео',style: Theme.of(context).textTheme.labelSmall)
                         ),
                         PopupMenuItem(
                             onTap: () {
                               CopyClipBoard().copy( video.urlVideo.toString(), "Ссылка скопировано");
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
                   ),
                 ],
               ),
             )
           ],
         ),
       ]
      ),
    );
  }


}

