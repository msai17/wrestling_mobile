// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:go_router/go_router.dart';
// import 'package:wrestling_hub/core/services/vk_video/src/utils/controllers/vk_video_controller.dart';
// import 'package:wrestling_hub/core/services/vk_video/vk_video.dart';
// import 'package:wrestling_hub/core/widgets/wrestling_info_alertdialog.dart';
// class VideoTestScreen extends StatefulWidget {
//
//
//   const VideoTestScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _VideoVkPlayerScreen();
//
// }
//
// class _VideoVkPlayerScreen extends State<VideoTestScreen>{
//
//
//   // VKVideoController? _controller;
//   // int currentTime = 0;
//   // bool isMute = false;
//   // bool isPlay = false;
//
//   @override
//   void initState() {
//     // _controller = VKVideoController();
//     // _controller?.addListener(_videoListener);
//     super.initState();
//   }
//
//
//   // _videoListener() async {
//   //   isMute = _controller!.getIsMuted;
//   //   isPlay = _controller!.getPlayerState == PlayerStateEnum.playing;
//   //   debugPrint("position: ${_controller!.getCurrentTime}");
//   //   debugPrint("currentTime: $currentTime");
//   //   debugPrint("isMute: $isMute");
//   //   debugPrint("duration: ${_controller?.getDuration}");
//   //   debugPrint("volume: ${_controller?.getVolume}");
//   //   debugPrint("quality: ${_controller?.getQuality}");
//   //   debugPrint("quality: ${_controller?.getQuality}");
//   //   debugPrint("player state: ${_controller?.getPlayerState}");
//   // }
//
//
//   @override
//   void dispose() {
//     // _controller?.onPause;
//     // _controller!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         child: Stack(
//           children: [
//
// //             HtmlWidget(
// //               '''
// // <video controls width="250">
// // <iframe width="1280" height="720" src="https://www.youtube.com/embed/M-peGbXCvNA" title="Видео курс по языку PHP, Язык программирования PHP в одном уроке" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>  <code>VIDEO</code> support is not enabled.
// // </video>''',
//               // factoryBuilder: () => Siz(),
//             ),
//             // Center(
//             //   child: VKVideo(
//             //     controller: _controller,
//             //     videoOId: '-213200306',
//             //     videoId: '456239020',
//             //     isAutoPlay: true,
//             //     videoResolutionEnum: VideoResolutionEnum.p1080,
//             //     videoStartTime: const Duration(seconds: 3),
//             //     backgroundColor: const Color(0xFF000000),
//             //     initialWidget: const Text(
//             //       "Loading....",
//             //       style: TextStyle(
//             //         color: Color(0xFFFFFFFF),
//             //       ),
//             //     ),
//             //   ),
//             // ),
//             // Positioned(
//             //   bottom: 0,
//             //   right: 0,
//             //   left: 0 ,
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       TextButton(
//             //         onPressed: () {
//             //           print('111click playpause');
//             //           setState(() {
//             //             if(_controller!.getPlayerState != PlayerStateEnum.playing) {
//             //               _controller?.onPlay();
//             //             }else{
//             //               _controller?.onPause();
//             //             }
//             //           });
//             //         },
//             //         child: Icon(_controller!.getPlayerState == PlayerStateEnum.playing ? Icons.play_arrow : Icons.pause, size: 35),
//             //       ),
//             //       TextButton(
//             //         onPressed: () {
//             //           setState(() {
//             //             if(isMute) {
//             //               isMute = false;
//             //               _controller?.onUnMute();
//             //             }else{
//             //               _controller?.onMute();
//             //               isMute = true;
//             //             }
//             //           });
//             //         },
//             //         child: Icon(isMute ? Icons.volume_off : Icons.volume_up, size: 35),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//  // }
// }