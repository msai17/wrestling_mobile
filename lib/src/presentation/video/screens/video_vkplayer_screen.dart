import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/core/services/vk_video/src/utils/controllers/vk_video_controller.dart';
import 'package:wrestling_hub/core/services/vk_video/vk_video.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_info_alertdialog.dart';
class VideoVkPlayerScreen extends StatefulWidget {

  final Video video;

  const VideoVkPlayerScreen({super.key, required this.video});

  @override
  State<StatefulWidget> createState() => _VideoVkPlayerScreen();

}

class _VideoVkPlayerScreen extends State<VideoVkPlayerScreen>{

  String oid = '';
  String id = '';
  VKVideoController? _controller;

  @override
  void initState() {
    _controller = VKVideoController();
    checkLink();
    super.initState();
  }


  void checkLink() {
    String url =  widget.video.urlVideo!;
    final regex = RegExp(r"video(-?\d+)_(\d+)");
    final match = regex.firstMatch(url);

    if (match != null) {
      oid = match.group(1)!; // Данные после "video-" до "_"
      id = match.group(2)!; // Цифры после "_"

      print(oid);
      print(id);

    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        WrestlingInfoAlertdialog(
            title: 'Ошибка',
            onClose: () {
              GoRouter.of(context).pop();
              GoRouter.of(context).pop();
            },
            contentWidget: Text("Произошла ошибка при загрузке видео",style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center)
        ).showAlertDialog(context);
      });
    }
  }

  @override
  void dispose() {
    _controller?.onPause;
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: VKVideo(
            controller: _controller,
            videoOId: oid,
            videoId: id,
            height: 250,
            isIframeAllowFullscreen: false,
            isAllowsInlineMediaPlayback: true,
            isAutoPlay: true,
            videoResolutionEnum: VideoResolutionEnum.p1080,
            backgroundColor: const Color(0xFF000000),
            initialWidget: const Text(
              "Загрузка....",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
    );
  }
}