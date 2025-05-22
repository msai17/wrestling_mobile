import 'package:firebase_core/firebase_core.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/constants/app_hive_boxes.dart';
import 'package:wrestling_hub/core/services/firebase/firebase_options.dart';
import 'package:wrestling_hub/core/services/firebase/firebase_service.dart';
import 'package:wrestling_hub/src/data/main/data_source/api/main_data_source.dart';
import 'package:wrestling_hub/src/data/main/data_source/local/main_local_data_source.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/data/main/repository/main_repository_impl.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_local_data_source.dart';
import 'package:wrestling_hub/src/data/user/data_source/remote/user_remote_data_source.dart';
import 'package:wrestling_hub/src/data/user/repository_impl/user_repository_impl.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';
import 'package:wrestling_hub/src/data/video/data_source/api/video_remote_data_source.dart';
import 'package:wrestling_hub/src/data/video/data_source/local/video_local_data_source.dart';
import 'package:wrestling_hub/src/data/video/models/video.dart';
import 'package:wrestling_hub/src/data/video/repository_impl/video_repository_impl.dart';
import 'package:wrestling_hub/src/domain/main/repository/main_repository.dart';
import 'package:wrestling_hub/src/domain/main/usecases/add_favorite_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/check_favorite_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/delete_favorite_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_comments_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_favorite_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_full_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_main_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/get_search_news_usecase.dart';
import 'package:wrestling_hub/src/domain/main/usecases/send_news_comment_usecase.dart';
import 'package:wrestling_hub/src/domain/user/repository/user_repository.dart';
import 'package:wrestling_hub/src/domain/user/usecases/confirm_code_use_case.dart';
import 'package:wrestling_hub/src/domain/user/usecases/delete_user_usecase.dart';
import 'package:wrestling_hub/src/domain/user/usecases/edit_user_usecase.dart';
import 'package:wrestling_hub/src/domain/user/usecases/get_local_user_usecase.dart';
import 'package:wrestling_hub/src/domain/user/usecases/get_user_use_case.dart';
import 'package:wrestling_hub/src/domain/user/usecases/send_image_server_usecase.dart';
import 'package:wrestling_hub/src/domain/video/repository/video_repository.dart';
import 'package:wrestling_hub/src/domain/video/usecases/add_video_usecase.dart';
import 'package:wrestling_hub/src/domain/video/usecases/delete_video_usecase.dart';
import 'package:wrestling_hub/src/domain/video/usecases/get_favorite_videos_usecase.dart';
import 'package:wrestling_hub/src/domain/video/usecases/get_videos_usecase.dart';
import 'package:wrestling_hub/src/domain/video/usecases/is_favorite_video_usecase.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/auth/auth_bloc.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/number_phone/number_phone_bloc.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/splash/splash_bloc.dart';
import 'package:wrestling_hub/src/presentation/favorites/blocs/favorite_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/main/main_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_comments/news_comment_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_details/details_news_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_search/search_news_bloc.dart';
import 'package:wrestling_hub/src/presentation/profile/blocs/edit/edit_bloc.dart';
import 'package:wrestling_hub/src/presentation/profile/blocs/profile/profile_bloc.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/video_cubit/video_favorite_cubit.dart';
import 'package:wrestling_hub/src/presentation/video/cubits/videos/videos_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  //local data storages
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(NewsAdapter());
  Hive.registerAdapter(VideoAdapter());
  final boxNews = await Hive.openBox<News>(AppHiveBoxes.boxNews);
  final boxVideos = await Hive.openBox<Video>(AppHiveBoxes.boxVideos);
  UserData userData = UserData.instance;
  await userData.initStorage();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //dependencies
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<Logger>(Logger());

  // Data sources
  sl.registerSingleton<MainDataSource>(MainDataSource(sl()));
  sl.registerSingleton<MainLocalDataSource>(MainLocalDataSource(boxNews));
  sl.registerSingleton<MainRepository>(MainRepositoryImpl(sl(), sl(),sl()));
  sl.registerSingleton<UserLocalDataSource>(UserLocalDataSource(userData));
  sl.registerSingleton<UserRemoteDataSource>(UserRemoteDataSource(sl()));
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl(), sl(),sl(),userData));
  sl.registerSingleton<VideoRemoteDataSource>(VideoRemoteDataSource(sl()));
  sl.registerSingleton<VideoLocalDataSource>(VideoLocalDataSource(boxVideos));
  sl.registerSingleton<VideoRepository>(VideoRepositoryImpl(sl(),sl(),sl()));

  //UseCases
  sl.registerSingleton<GetMainUseCase>(GetMainUseCase(sl()));
  sl.registerSingleton<GetFullNewsUseCase>(GetFullNewsUseCase(sl()));
  sl.registerSingleton<GetSearchNewsUseCase>(GetSearchNewsUseCase(sl()));
  sl.registerSingleton<GetCommentsNewsUseCase>(GetCommentsNewsUseCase(sl()));
  sl.registerSingleton<SendNewsCommentUseCase>(SendNewsCommentUseCase(sl()));
  sl.registerSingleton<ConfirmCodeUseCase>(ConfirmCodeUseCase(sl()));
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase(sl()));
  sl.registerSingleton<GetLocalUserUseCase>(GetLocalUserUseCase(sl()));
  sl.registerSingleton<EditUserUseCase>(EditUserUseCase(sl()));
  sl.registerSingleton<DeleteUserUseCase>(DeleteUserUseCase(sl()));
  sl.registerSingleton<SendImageServerUseCase>(SendImageServerUseCase(sl()));
  sl.registerSingleton<AddFavoriteNewsUseCase>(AddFavoriteNewsUseCase(sl()));
  sl.registerSingleton<DeleteFavoriteNewsUseCase>(DeleteFavoriteNewsUseCase(sl()));
  sl.registerSingleton<CheckFavoriteNewsUseCase>(CheckFavoriteNewsUseCase(sl()));
  sl.registerSingleton<GetFavoriteNewsUseCase>(GetFavoriteNewsUseCase(sl()));
  sl.registerSingleton<IsFavoriteVideoUseCase>(IsFavoriteVideoUseCase(sl()));
  sl.registerSingleton<AddFavoriteVideoUseCase>(AddFavoriteVideoUseCase(sl()));
  sl.registerSingleton<DeleteFavoriteVideoUseCase>(DeleteFavoriteVideoUseCase(sl()));
  sl.registerSingleton<GetFavoriteVideosUseCase>(GetFavoriteVideosUseCase(sl()));
  sl.registerSingleton<GetVideosUseCase>(GetVideosUseCase(sl()));


  //services
  sl.registerSingleton<FirebaseService>(FirebaseService(sl(),userData));

  // Blocs
  sl.registerFactory<MainBloc>(() => MainBloc(sl(), sl(),sl()));
  sl.registerFactory<DetailsNewsBloc>(() => DetailsNewsBloc(sl(), sl(),sl(),sl(),sl()));
  sl.registerFactory<SearchNewsBloc>(() => SearchNewsBloc(sl(), sl()));
  sl.registerFactory<NewsCommentBloc>(() => NewsCommentBloc(sl(),sl(),sl(),userData));
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(),sl(),sl()));
  sl.registerFactory<NumberPhoneBloc>(() => NumberPhoneBloc());
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl(),sl(),userData));
  sl.registerFactory<FavoriteBloc>(() => FavoriteBloc(sl(),sl()));
  sl.registerFactory<SplashBloc>(() => SplashBloc(sl(),sl(),userData));
  sl.registerFactory<EditBloc>(() => EditBloc(sl(),sl(),sl(),sl(),sl(),userData));
  sl.registerFactory<VideosCubit>(() => VideosCubit(sl(),sl()));
  sl.registerFactory<VideoFavoriteCubit>(() => VideoFavoriteCubit(sl(),sl(),sl()));

}