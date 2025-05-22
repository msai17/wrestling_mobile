import 'package:go_router/go_router.dart';
import 'package:wrestling_hub/core/constants/app_colors.dart';
import 'package:wrestling_hub/core/utils/navbar_item.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigation extends StatefulWidget  {
  final StatefulNavigationShell navigationShell;

  const HomeBottomNavigation({super.key, required this.navigationShell});

  @override
  State<StatefulWidget> createState() => _HomeBottomNavigation();

}

class _HomeBottomNavigation extends State<HomeBottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: _navBar(context),
      ),
    );
  }



  Widget _navBar(BuildContext context) {
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
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (index)  {
          widget.navigationShell.goBranch(index);
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
}