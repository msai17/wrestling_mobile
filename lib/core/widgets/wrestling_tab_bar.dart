import 'package:flutter/material.dart';
import 'package:wrestling_hub/core/constants.dart';
class WrestlingTabBar extends StatelessWidget {

  final TabController? controller;
  final List<Widget> tabs;

  const WrestlingTabBar({super.key,required this.controller, required this.tabs});




  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xff7E7E7E),
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        padding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        indicatorColor: WrestlingColors.color_red,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: WrestlingColors.color_red, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          insets: EdgeInsets.only(bottom: 6),
        ),
        tabs: tabs
    );
  }



}