part of 'navbar_main_bloc.dart';

@immutable
sealed class NavbarMainEvent {
  const NavbarMainEvent();
}

class NavbarItemPressed extends NavbarMainEvent {
  const NavbarItemPressed(this.tappedItem,this.page);
  final NavbarItem tappedItem;
  final int page;
}
