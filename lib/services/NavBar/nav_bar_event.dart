part of 'nav_bar_bloc.dart';

@immutable
sealed class NavBarEvent {
  const NavBarEvent();
}

class ChangeTab extends NavBarEvent {
  final int index;
  const ChangeTab(this.index);

  List<Object> get props => [index];
}
