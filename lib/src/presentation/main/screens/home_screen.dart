import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/core/utils/navbar_item.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/main/main_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/widgets/wrestling_news_card.dart';
import 'package:wrestling_hub/src/presentation/main/widgets/wrestling_news_top_card.dart';
import 'package:wrestling_hub/src/presentation/navigation/bloc/navbar_main_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/error_page.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_progress_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  ScrollController newsScrollController = ScrollController();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    newsScrollController.addListener(() => _newsScrollListener());
  }

  _newsScrollListener() {
    if (newsScrollController.position.pixels == newsScrollController.position.maxScrollExtent) {
      context.read<MainBloc>().add(NewsLoadMoreEvent());
    }
  }

  @override
  void dispose() {
    newsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BlocBuilder<NavbarMainBloc, NavbarMainState>(
          builder: (context, state) {
            return Row(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    context.read<NavbarMainBloc>().add(NavbarItemPressed(NavbarItem.values.elementAt(2),2));
                    },
                  child: const SizedBox()
                ),
                const SizedBox(width: 10),
                Text('Wrestling Hub',style: Theme.of(context).textTheme.titleLarge),
              ],
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(AppRoute.search);
              },
              icon: const Icon(Icons.search_rounded)
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        color: AppColors.colorAccent,
        strokeWidth: 2.75,
        backgroundColor: AppColors.colorBackground,
        onRefresh: () async {
          context.read<MainBloc>().page = 0;
          return context.read<MainBloc>().add(NewsFetchEvent());
          },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              controller: newsScrollController,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: BlocBuilder<MainBloc,NewsState>(
                    bloc: context.read(),
                    builder: (context, state) {
                      if(state is MainErrorState) {
                        return SizedBox(
                          height: constraints.maxHeight,
                          child: ErrorPage(
                            errorText: state.error,
                            icon: Icons.error_outline_sharp,
                            buttonText: 'Повторить',
                            onPress: () {
                              context.read<MainBloc>().page = 0;
                              context.read<MainBloc>().add(NewsFetchEvent());
                            },
                          ),
                        );
                      }
                      if(state is InitMainState) {
                        context.read<MainBloc>().add(NewsFetchEvent());
                      }
                      if(state is MainLoadingState) {
                        return const Center(
                            child: WrestlingProgressBar(),
                        );
                      }
                      if(state is MainLoadedState) {
                        final news = state.news;
                        final topNews = state.topNewsHeadlines;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Лучшие подборки', style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                child: SizedBox(
                                  height: 340,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemCount: topNews!.length,
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return WrestlingNewsTopCard(news: topNews[index]);
                                      }
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text('Полный список новостей', style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center),
                              const SizedBox(height: 10),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: context.read<MainBloc>().isLoadingMore ? news.length + 1 : news.length,
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    if (index >= news.length) {
                                      return Center(child: context.read<MainBloc>().isLastPage ? Text('Вы загрузили максимальное количество новостей', style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,)
                                          : const WrestlingProgressBar());
                                    } else {
                                      return WrestlingNewsCard(
                                        news: news[index],
                                        onPressed: (News news) {
                                          GoRouter.of(context).pushNamed(AppRoute.full_news, extra: news);
                                        },
                                      );
                                    }
                                  }
                              ),
                            ],
                          ),
                        );}
                      return Center(child: Text('Упс. Что-то пошло не так', style: Theme.of(context).textTheme.titleMedium));
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
