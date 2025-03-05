import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/navbar_item.dart';


part 'navbar_main_event.dart';
part 'navbar_main_state.dart';

class NavbarMainBloc extends Bloc<NavbarMainEvent, NavbarMainState> {

  PageController  pageController = PageController();


  NavbarMainBloc() : super(const NavbarMainState(NavbarItem.home)) {
    on<NavbarItemPressed>((event, emit) {
      pageController.jumpToPage(event.page);
      emit(NavbarMainState(event.tappedItem));
    });
  }
}
