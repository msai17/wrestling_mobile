import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NavbarItem {

  home("Главная",Colors.black, CupertinoIcons.home),
  video("Смотреть",Colors.black, Icons.slow_motion_video_outlined),
  favorites("Мое",Colors.black, Icons.favorite),
  profile("Профиль",Colors.black, Icons.account_circle_outlined);

  const NavbarItem(this.name, this.color, this.icon);

  final String name;
  final Color color;
  final IconData icon;
}