import 'package:wrestling_hub/src/presentation/favorites/blocs/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_hub/src/presentation/favorites/widgets/favorites_news_carousel.dart';
import 'package:wrestling_hub/src/presentation/favorites/widgets/favorites_videos_carousel.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_tab_bar.dart';

class FavoritesScreen extends StatefulWidget {


  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with TickerProviderStateMixin {

  TabController? _controllerTab;

  @override
  void initState() {
    _controllerTab = TabController(length: 2, vsync: this);
    context.read<FavoriteBloc>().add(FavoriteGetEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Сохраненное', style: Theme.of(context).textTheme.titleLarge),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child:  WrestlingTabBar(
            controller: _controllerTab,
            tabs: const [
              Tab(text: 'Новости'),
              Tab(text: 'Видео'),
            ],
          ),
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if(state is FavoriteLoadedState) {
            return SafeArea(
              child: TabBarView(
                  controller: _controllerTab,
                  children: [
                    FavoritesNewsCarousel(newsList: state.news!),
                    FavoritesVideosCarousel(videos: state.videos!),
                  ]
              )
            );
          }
         return const SizedBox();
        },
      ),
    );
  }

}
