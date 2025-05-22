import 'package:wrestling_hub/core/route/app_router_config.dart';
import 'package:wrestling_hub/core/theme.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/auth/auth_bloc.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/number_phone/number_phone_bloc.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/splash/splash_bloc.dart';
import 'package:wrestling_hub/src/presentation/favorites/blocs/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/main/main_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_comments/news_comment_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_details/details_news_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_search/search_news_bloc.dart';
import 'package:wrestling_hub/src/presentation/profile/blocs/edit/edit_bloc.dart';
import 'package:wrestling_hub/src/presentation/profile/blocs/profile/profile_bloc.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/video_cubit/video_favorite_cubit.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/videos/videos_cubit.dart';
import 'di.dart';

class WrestlingSakhaApp extends StatefulWidget{

  const WrestlingSakhaApp({super.key});


  @override
  State<StatefulWidget> createState() => _WrestlingSakhaApp();
}

class _WrestlingSakhaApp extends State<WrestlingSakhaApp>{

  final _appRouterConfig = AppRouterConfig();

  @override
  void dispose() {
    _appRouterConfig.router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(create: (context) => sl()),
        BlocProvider<DetailsNewsBloc>(create: (context) => sl()),
        BlocProvider<SearchNewsBloc>(create: (context) => sl()),
        BlocProvider<NewsCommentBloc>(create: (context) => sl()),
        BlocProvider<AuthBloc>(create: (context) => sl()),
        BlocProvider<NumberPhoneBloc>(create: (context) => sl()),
        BlocProvider<ProfileBloc>(create: (context) => sl()),
        BlocProvider<EditBloc>(create: (context) => sl()),
        BlocProvider<SplashBloc>(create: (context) => sl()),
        BlocProvider<FavoriteBloc>(create: (context) => sl()),
        BlocProvider<VideosCubit>(create: (context) => sl()),
        BlocProvider<VideoFavoriteCubit>(create: (context) => sl()),
      ],
      child: MaterialApp.router(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouterConfig.router,
      ),
    );
  }



}