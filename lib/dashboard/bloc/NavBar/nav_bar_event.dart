part of 'nav_bar_bloc.dart';

@immutable
sealed class NavBarEvent {
  NavBarEvent();
}

class ChangeTab extends NavBarEvent {
  final int index;
  ChangeTab(this.index);

  @override
  List<Object> get props => [index];
}
