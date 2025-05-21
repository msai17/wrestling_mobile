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
      routes: routes,
      initialLocation: AppRoute.root,
  );

  List<RouteBase> get routes => [
    GoRoute(
        path: AppRoute.root,
        name: AppRoute.root,
        builder: (BuildContext context,state) {
          return const SplashScreen();
        }
    ),
    GoRoute(
        path: AppRoute.phoneField,
        name: AppRoute.phoneField,
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
        path: AppRoute.profileEdit,
        name: AppRoute.profileEdit,
        builder: (BuildContext context,state) => const ProfileEditScreen(),
    ),
    GoRoute(
        path: AppRoute.onboard,
        name: AppRoute.onboard,
        builder: (BuildContext context,state) => const OnBoardingScreen()
    ),
    GoRoute(
        path: AppRoute.home,
        name: AppRoute.home,
        builder: (BuildContext context,state) => const NavBarMainScreen()
    ),
    GoRoute(
        path: AppRoute.searchNews,
        name: AppRoute.searchNews,
        builder: (context, state)  =>  const SearchNewsScreen()
    ),
    GoRoute(
        path: AppRoute.fullNews,
        name: AppRoute.fullNews,
        builder: (context, state)  {
          News fullNews = state.extra as News;
          return FullNewsScreen(
            fullNews: fullNews
          );
        }
    ),
    GoRoute(
        path: '/news/comments/:id',
        name: AppRoute.commentNews,
        builder: (context, state)  {
          return NewsCommentsScreen(
            idNews: state.pathParameters['id'].toString(),
          );
        }
    ),
    GoRoute(
        path: AppRoute.vkVideoInfo,
        name: AppRoute.vkVideoInfo,
        builder: (context, state)  {
          Video video = state.extra as Video;
          return VideoVkPlayerScreen(
              video: video
          );
        }
    ),
    GoRoute(
        path: AppRoute.vkVideoInfo,
        name: AppRoute.vkVideoInfo,
        builder: (context, state)  {
          return const VideoInfoScreen();
        }
    ),
    GoRoute(
        path: AppRoute.privacy,
        name: AppRoute.privacy,
        builder: (context, state)  {
          return const PrivacyPolicyScreen();
        }
    ),
  ];
}