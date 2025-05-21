import 'dart:io';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/constants/app_urls.dart';
import 'package:wrestling_hub/core/route/app_router.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/modal_bottom_feedback.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_button.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_info_alertdialog.dart';
import 'package:wrestling_hub/src/presentation/shared/widgets/wrestling_simple_alertdialog.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/auth/auth_bloc.dart';
import 'package:wrestling_hub/src/presentation/auth/blocs/auth/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wrestling_hub/src/presentation/profile/blocs/profile/profile_bloc.dart';
import 'package:wrestling_hub/src/presentation/profile/widgets/profile_menu_feedback.dart';
import 'package:wrestling_hub/src/presentation/profile/widgets/profile_menu_item.dart';
import 'package:wrestling_hub/src/presentation/profile/widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<StatefulWidget> createState() => _ProfileScreen();
}
class _ProfileScreen extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
       bloc: context.read<ProfileBloc>()..add(ProfileGetLocalEvent()),
       builder: (context, state) {
         if(state is ProfileNoLoggedState) {
           final stateAuth = context.watch<AuthBloc>().state;
            if(stateAuth is AuthSuccessState) {
              context.read<ProfileBloc>().add(ProfileGetLocalEvent());
            }}
         return SafeArea(
           child: Scaffold(
             appBar: AppBar(
               centerTitle: true,
               title: Text('Профиль', style: Theme.of(context).textTheme.titleLarge),
               actions: [
                 PopupMenuButton(
                   icon: const Icon(CupertinoIcons.settings),
                   color: Colors.black,
                   itemBuilder: (context) => [
                     if(state is ProfileLoggedState)
                     PopupMenuItem(
                        onTap: () {
                          WrestlingSimpleAlertDialog(
                            title: 'Выход',
                            description: 'Вы точно хотите выйти из аккаунта ?',
                            onYesButton: () {
                              GoRouter.of(context).pop();
                              context.read<ProfileBloc>().add(ProfileExitEvent());
                            },
                            onNoButton: () {
                              GoRouter.of(context).pop();
                            },
                          ).showAlertDialog(context);
                        },
                         child:Text('Выйти из аккаунта',style: Theme.of(context).textTheme.titleSmall)
                     ),
                     PopupMenuItem(
                       onTap: () {
                          WrestlingInfoAlertdialog(
                            title: 'Текущая версия приложения',
                            onClose: () {
                              GoRouter.of(context).pop();
                            },
                            contentWidget: Text("1.0.1",style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center)
                          ).showAlertDialog(context);
                       },
                      child:Text('Версия приложения',style: Theme.of(context).textTheme.titleSmall)
                     )
                 ],
                 )
               ],
             ),
             body: SingleChildScrollView(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     state is ProfileLoggedState ? Column(
                       mainAxisSize: MainAxisSize.min,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const SizedBox(height: 20),
                         ProfileWidget(avatar: state.user.avatars,width: 90,height: 90,),
                         const SizedBox(height: 12),
                         Text(state.user.getInitials(), style: Theme.of(context).textTheme.titleLarge),
                         const SizedBox(height: 2),
                         Text('Дата регистрации: ${state.user.creationDateTime}', style: Theme.of(context).textTheme.titleSmall),
                         const SizedBox(height: 2),
                         Row(
                           children: [
                             Text('Статус:',style: Theme.of(context).textTheme.titleSmall),
                             const SizedBox(width: 10),
                             InkWell(
                                 highlightColor: Colors.transparent,
                                 splashColor: Colors.transparent,
                                 onTap: () {
                                   WrestlingInfoAlertdialog(
                                     title: 'Статусы',
                                     contentWidget: const Column(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Row(
                                           children: [
                                             Icon(Icons.verified,color: Colors.blueGrey),
                                             Text('Не заполненный аккаунт')
                                           ],
                                         ),
                                         SizedBox(height: 5),
                                         Row(
                                           children: [
                                             Icon(Icons.verified,color: Colors.cyan),
                                             Text('Аккаунт заполнен'),
                                           ],
                                         ),
                                         SizedBox(height: 5),
                                         Row(
                                           children: [
                                             Icon(Icons.verified,color: Colors.amber),
                                             Text('Активный')
                                           ],
                                         ),
                                       ],
                                     ),
                                     onClose: () {
                                       GoRouter.of(context).pop();
                                     },
                                   ).showAlertDialog(context);
                                   },
                                 child: state.icon)
                           ],
                         )
                       ],
                     ) : const SizedBox(),
                     Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: WrestlingButton(
                           height: 40,
                           titleWidget: Text(state is ProfileLoggedState ? 'Редактировать профиль' : 'Войти в профиль', style: const TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Crimson')),
                           primaryColor: AppColors.colorBottomNav,
                           isFilled: true,
                           onPressed: () async {
                             if(state is ProfileLoggedState) {
                               GoRouter.of(context).pushNamed(AppRoute.profile_edit).then((val) {
                                 if(context.mounted) {
                                   if(val == true) {
                                     context.read<ProfileBloc>().add(ProfileGetLocalEvent());
                                   }
                                 }
                               });
                             }else{
                               GoRouter.of(context).pushNamed(AppRoute.auth).then((val) {
                                 if(val == 'auth') {
                                   if(context.mounted) {
                                     context.read<ProfileBloc>().add(ProfileGetLocalEvent());
                                   }
                                 }
                               });
                             }
                           }
                       ),
                     ),
                     InkWell(
                       splashColor: Colors.transparent,
                       highlightColor: Colors.transparent,
                       onTap: () {
                         launchUrl(Uri.parse(AppUrls.donatLink));
                         },
                       child: Container(
                         margin: const EdgeInsets.all(12.0),
                         padding: const EdgeInsets.all(8.0),
                         decoration: BoxDecoration(
                             color: AppColors.colorBottomNav,
                             borderRadius: BorderRadius.circular(10),
                             border: Border.all(color: AppColors.colorSmallText,width: 1)
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const SizedBox(height: 10),
                             Text('Поддержать разработчика',style: Theme.of(context).textTheme.titleLarge),
                             const SizedBox(height: 5),
                             Text('Помогите нам улучшать приложение чаще! Ваш донат напрямую будет способствовать разработке новых функций, исправлению ошибок и общему усовершенствованию приложения Wrestling Hub. Ваша поддержка является ключевой для обеспечения актуальности нашего приложения и предоставления лучшего возможного опыта для наших пользователей.',style: Theme.of(context).textTheme.labelSmall),
                             const SizedBox(height: 5),
                             RichText(
                               textAlign: TextAlign.start,
                               text: const TextSpan(
                                 children: <TextSpan>[
                                   TextSpan(text: AppUrls.donatLink, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'Roboto', color: Colors.cyanAccent, decoration: TextDecoration.underline)),
                                 ],
                               ),
                             ),
                             const SizedBox(height: 10),
                           ],
                         ),
                       ),
                     ),
                     Column(
                       children: [
                         ProfileMenuItem(
                             title: 'Политика конфиденциальности',
                             icon: CupertinoIcons.doc_append,
                             endIcon: true,
                             onPress: () {
                               launchUrl(Uri.parse(AppUrls.privacy));
                             }
                             ),
                         Platform.isAndroid ?
                         ProfileMenuItem(
                             title: 'Поделиться с друзьями',
                             icon: CupertinoIcons.share,
                             endIcon: false,
                             onPress: ()  async {
                               await Share.share('Установите мобильное приложение Amonlexa Wrestling Hub, забронируйте  место в 1 клик\n ${AppUrls.storeApp}');
                             }
                             ) : const SizedBox(),
                         ProfileMenuItem(
                             title: 'Оценить приложение',
                             icon: CupertinoIcons.star,
                             endIcon: false,
                             onPress: () async {
                               launchUrl(Uri.parse(AppUrls.storeApp));
                             }
                             ),
                       ],
                     ),
                     const SizedBox(height: 12),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Обратная связь',style: Theme.of(context).textTheme.titleLarge),
                         const SizedBox(height: 20),
                         ProfileMenuFeedback(
                           title: 'Наши контакты',
                           endIcon: true,
                           onPress: () {
                             const ModalBottomFeedback().show(context);
                             },
                         ),
                         const SizedBox(height: 20),
                       ],
                     ),
                   ],
                 ),
               ),
             ),
           )
         );
         },
      ),
    );
  }


}