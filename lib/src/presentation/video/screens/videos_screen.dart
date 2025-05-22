import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/error_page.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_progress_bar.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_tab_bar.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/videos/videos_cubit.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/videos/videos_state.dart';
import 'package:wrestling_hub/src/presentation/video/screens/video_test_screen.dart';

class VideosScreen extends StatefulWidget {

  const VideosScreen({super.key});

  @override
  State<StatefulWidget> createState() => _VideosScreen();

}

class _VideosScreen extends State<VideosScreen> with TickerProviderStateMixin{

  TabController? _controller_tab;


  @override
  void initState() {
    context.read<VideosCubit>().onGetVideos(false);
    _controller_tab = TabController(vsync: this, length: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller_tab?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoTestScreen()));
      //   },
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('WH Видео', style: Theme.of(context).textTheme.titleLarge),
        bottom: PreferredSize(
         preferredSize: const Size.fromHeight(50.0),
          child: BlocListener<VideosCubit, VideosState> (
            bloc: context.read(),
            listener: (BuildContext context, VideosState state) {
              if(state is VideosSuccessState) {
                if(!state.isRefresh) {
                  _controller_tab = TabController(length: state.tabs.length, vsync: this);
                }
              }
            },
            child: BlocBuilder<VideosCubit, VideosState>(
              builder: (context, state) {
                if (state is VideosLoadingState) {
                  return const Center(child: WrestlingProgressBar());
                } else if (state is VideosSuccessState) {
                  return WrestlingTabBar(
                    controller: _controller_tab,
                    tabs: state.tabs,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            GoRouter.of(context).push(AppRoute.vkVideoInfo);
          }, 
          icon: const Icon(Icons.info_outline))
        ],
      ),
      body: NestedScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [];
        },
        body: BlocBuilder<VideosCubit, VideosState>(
          builder: (context, state) {
            if (state is VideosFailureState) {
              return ErrorPage(
                  errorText: state.message,
                  buttonText: 'Повторить',
                  onPress: () {
                    context.read<VideosCubit>().onGetVideos(false);
                  },
                  icon: Icons.videocam_off_outlined
              );
            }
            if (state is VideosLoadingState) {
              return const Center(child: WrestlingProgressBar());
            }
            if (state is VideosSuccessState) {
              return TabBarView(
                controller: _controller_tab,
                children: state.pages.map((page) {
                  return RefreshIndicator(
                    color: AppColors.colorRed,
                      strokeWidth: 2.75,
                      backgroundColor: AppColors.colorBackground,
                      onRefresh: () async {
                      return await context.read<VideosCubit>().onGetVideos(true);
                    },
                    child: page
                  );
                }).toList(),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }



}