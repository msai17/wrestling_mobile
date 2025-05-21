import 'package:wrestling_hub/core/constants/app_config.dart';
import 'package:wrestling_hub/core/services/firebase/firebase_service.dart';
import 'package:wrestling_hub/core/utils/navbar_item.dart';
import 'package:wrestling_hub/src/presentation/favorites/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_hub/src/presentation/main/screens/home_screen.dart';
import 'package:wrestling_hub/src/presentation/navigation/bloc/navbar_main_bloc.dart';
import 'package:wrestling_hub/src/presentation/profile/screens/profile_screen.dart';
import 'package:wrestling_hub/src/presentation/video/screens/videos_screen.dart';

import '../../../../core/constants/app_colors.dart';

class NavBarMainScreen extends StatefulWidget  {

  const NavBarMainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NavBarMainScreen();

}

class _NavBarMainScreen extends State<NavBarMainScreen> {

  HomeScreen? _homeScreen;
  VideosScreen? _videoScreen;
  ProfileScreen? _profileScreen;
  FavoritesScreen? _favoritesScreen;


  @override
  void initState() {
    _homeScreen = const HomeScreen();
    _videoScreen = const VideosScreen();
    _profileScreen = const ProfileScreen();
    _favoritesScreen = const FavoritesScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NavbarMainBloc,NavbarMainState>(
          builder: (context, state) {
            return SizedBox.expand(
              child: PageView(
                controller: context.read<NavbarMainBloc>().pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget> [
                  _homeScreen!,
                  _videoScreen!,
                  _favoritesScreen!,
                  _profileScreen!,
                ],
              ),
            );
            }
        ),
        bottomNavigationBar: _navBar(context),
      ),
    );
  }



  Widget _navBar(BuildContext context) {
    return BlocBuilder<NavbarMainBloc,NavbarMainState>(
      builder: (context, state) {
        return NavigationBarTheme(data: NavigationBarThemeData(
          backgroundColor: AppColors.colorBottomNav,
          indicatorColor: AppColors.colorRed,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Crimson',
                letterSpacing: 1.0,
              );
            }
            return const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Crimson',
              letterSpacing: 1.0,
            );
          })),
          child: NavigationBar(
            height: 60,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            selectedIndex: state.item.index,
            onDestinationSelected: (index)  {
              context.read<NavbarMainBloc>().add(NavbarItemPressed(NavbarItem.values.elementAt(index),index));
            },
            destinations: [
              NavigationDestination(
                  icon: Icon(NavbarItem.home.icon, color: Colors.white,size: 18),
                  label: NavbarItem.home.name
              ),
              NavigationDestination(
                  icon: Icon(NavbarItem.video.icon, color: Colors.white,size: 18),
                  label: NavbarItem.video.name
              ),
              NavigationDestination(
                  icon: Icon(NavbarItem.favorites.icon, color: Colors.white,size: 18),
                  label: NavbarItem.favorites.name
              ),
              NavigationDestination(
                  icon: Icon(NavbarItem.profile.icon, color: Colors.white,size: 18),
                  label: NavbarItem.profile.name,
              ),
            ],
          ),
        );
      }
    );
  }
}