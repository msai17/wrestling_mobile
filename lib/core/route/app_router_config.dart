import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/presentation/auth/screens/confirm_code_screen.dart';
import 'package:wrestling_hub/src/presentation/auth/screens/number_phone_screen.dart';
import 'package:wrestling_hub/src/presentation/auth/screens/onboarding_screen.dart';
import 'package:wrestling_hub/src/presentation/auth/screens/privacy_policy_screen.dart';
import 'package:wrestling_hub/src/presentation/auth/screens/splash_screen.dart';
import 'package:wrestling_hub/src/presentation/main/screens/full_news_screen.dart';
import 'package:wrestling_hub/src/presentation/main/screens/news_comments_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/src/presentation/main/screens/search_news_screen.dart';
import 'package:wrestling_hub/src/presentation/navigation/screens/main_screen.dart';
import 'package:wrestling_hub/src/presentation/profile/screens/profile_edit_screen.dart';
import 'package:wrestling_hub/src/presentation/video/screens/video_info.dart';
import 'package:wrestling_hub/src/presentation/video/screens/video_vkplayer_screen.dart';
import 'app_router.dart';

class AppRouterConfig {

  late final GoRouter router = GoRouter(
      routes: _routes,
      initialLocation: AppRoute.root,
  );

  late final _routes = <RouteBase> [
    GoRoute(
        path: '/',
        name: AppRoute.root,
        builder: (BuildContext context,state) {
          return const SplashScreen();
        }
    ),
    GoRoute(
        path: '/auth',
        name: AppRoute.auth,
        builder: (BuildContext context,state) => const NumberPhoneScreen()
    ),
    GoRoute(
      path: '/sms/:number',
      name: AppRoute.sms,
      builder: (context, state)  {
        return ConfirmSmsCode(
          numberPhone: state.pathParameters['number'].toString(),
        );
      },
    ),
    GoRoute(
        path: '/profile/edit',
        name: AppRoute.profile_edit,
        builder: (BuildContext context,state) => const ProfileEditScreen(),
    ),
    GoRoute(
        path: '/onboard',
        name: AppRoute.onboard,
        builder: (BuildContext context,state) => const OnBoardingScreen()
    ),
    GoRoute(
        path: '/main',
        name: AppRoute.main,
        builder: (BuildContext context,state) => const NavBarMainScreen()
    ),
    GoRoute(
        path: '/search',
        name: AppRoute.search,
        builder: (context, state)  =>  const SearchNewsScreen()
    ),
    GoRoute(
        path: '/full_news',
        name: AppRoute.full_news,
        builder: (context, state)  {
          News fullNews = state.extra as News;
          return FullNewsScreen(
            fullNews: fullNews
          );
        }
    ),
    GoRoute(
        path: '/comments_news/:id',
        name: AppRoute.comment_news,
        builder: (context, state)  {
          return NewsCommentsScreen(
            idNews: state.pathParameters['id'].toString(),
          );
        }
    ),
    GoRoute(
        path: '/vk_video',
        name: AppRoute.vk_video,
        builder: (context, state)  {
          Video video = state.extra as Video;
          return VideoVkPlayerScreen(
              video: video
          );
        }
    ),
    GoRoute(
        path: '/vk_video_info',
        name: AppRoute.vk_video_info,
        builder: (context, state)  {
          return const VideoInfoScreen();
        }
    ),
    GoRoute(
        path: '/privacy',
        name: AppRoute.privacy,
        builder: (context, state)  {
          return const PrivacyPolicyScreen();
        }
    ),
  ];
}