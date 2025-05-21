import 'package:widget_zoom/widget_zoom.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_resource.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/data/main/models/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_details/details_news_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_details/details_news_event.dart';
import 'package:wrestling_hub/src/presentation/main/blocs/news_details/details_news_state.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/error_page.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/show_image.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_button.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_progress_bar.dart';

class FullNewsScreen extends StatefulWidget {

  final News fullNews;

  const FullNewsScreen({super.key,required this.fullNews});

  @override
  State<StatefulWidget> createState() => _FullNewsScreen();
}

class _FullNewsScreen extends State<FullNewsScreen>  {

  PageController? pageImagesController;


  @override
  void initState() {
    pageImagesController = PageController(keepPage: false);
    context.read<DetailsNewsBloc>().add(DetailsNewsFetchEvent(widget.fullNews));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsNewsBloc, DetailsNewsState> (
     bloc: context.read(),
     builder: (BuildContext context, DetailsNewsState state) {
       if (state is DetailsNewsLoadingState) {
         return const Center(
           child: WrestlingProgressBar() ,
         );
       }
       if (state is DetailsNewsErrorState) {
         return SizedBox(
           child: ErrorPage(
             errorText: state.error,
             icon: Icons.error_outline_sharp,
             buttonText: 'Повторить',
             onPress: () {
               context.read<DetailsNewsBloc>().add(DetailsNewsFetchEvent(widget.fullNews));
             },
           ),
         );
       }
       return Scaffold(
         appBar: state is DetailsNewsSuccessState ? AppBar(
           actions: [
             IconButton(
                 onPressed: () {
                   GoRouter.of(context).pushNamed(AppRoute.commentNews, pathParameters: {'id': '${state.full!.id}'});
                 },
                 icon: Row(
                   children: [
                     Text('${state.full!.commentsCount}',style: Theme.of(context).textTheme.labelSmall),
                     const SizedBox(width: 3),
                     const Icon(Icons.comment_sharp),
                   ],
                 )
             ),
             IconButton(
                 onPressed: () {
                   if(state.isFavorite) {
                     context.read<DetailsNewsBloc>().add(DetailNewsDeleteFavoriteEvent(state.full!));
                   }else{
                     context.read<DetailsNewsBloc>().add(DetailNewsAddFavoriteEvent(state.full!));
                   }
                 },
                 icon: Icon(state.isFavorite ? Icons.favorite : Icons.favorite_border)
             ),
             IconButton(
                 onPressed: () async {
                   String content = '${state.full!.title}\n${state.full!.description}\nИсточник:${state.full!.link}\nСкачать приложение: ${AppUrls.storeApp}';
                   await Share.share(content);
                   },
                 icon: SvgPicture.asset(AppResources.iconShare, colorFilter: const ColorFilter.mode(AppColors.colorRed, BlendMode.srcIn))
             ),
            ],
         ) : AppBar(),
         body: Container(
           margin: const EdgeInsets.all(15.0),
           alignment: Alignment.center,
           child: SingleChildScrollView(
             child:  state is DetailsNewsSuccessState ?
             Column(
               children: [
                 Text('${state.full!.title}', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.start),
                 const SizedBox(height: 10),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     Align(alignment: Alignment.centerLeft, child: Text('Источник: ${state.full!.author}', style: Theme.of(context).textTheme.labelSmall)),
                     Align(alignment: Alignment.centerLeft, child: Text('${state.full!.creationDateTime}', style: Theme.of(context).textTheme.labelSmall)),
                   ],
                 ),
                 const SizedBox(height: 10),
                 SizedBox(
                   height: 250,
                   child: PageView.builder(
                       controller: pageImagesController,
                       itemCount: state.full!.images!.split(',').length,
                       onPageChanged: (page) {
                       },
                       itemBuilder: (context,index) {
                         return Container(
                             margin: const EdgeInsets.symmetric(horizontal: 2),
                             child: WidgetZoom(
                                 heroAnimationTag: 'hero',
                                 zoomWidget: ShowImage(image: state.full!.images!.split(',')[index], height: 250, width: 0, circular: 20,isCard: false)
                             )
                         );
                       }
                   ),
                 ),
                 const SizedBox(height: 12),
                 state.full!.images!.split(',').length > 1 ? SmoothPageIndicator(
                     controller: pageImagesController!,
                     count: state.full!.images!.split(',').length,
                     effect: const ScrollingDotsEffect(
                         dotHeight: 5,
                         dotWidth: 5,
                         activeDotColor: AppColors.colorRed,
                         spacing: 5.0
                     ),
                     onDotClicked: (index) => pageImagesController!.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
                 ) : const SizedBox(),                 const SizedBox(height: 10),
                 Text('${state.full!.description}',style:Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.start,),
                 const SizedBox(height: 15),
                 state.full!.link!.isNotEmpty ? WrestlingButton(
                     height: 50,
                     titleWidget: const Text('Открыть источник', style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Roboto')),
                     primaryColor: AppColors.colorRed,
                     isFilled: true,
                     onPressed: () {
                       launchUrl(Uri.parse(state.full!.link!));
                     }) : const SizedBox(),
                 const SizedBox(height: 15)
               ],
             ) : const Center(child: Text("Что то пошло не так"))
       ),
        ));
      });
  }
}


