part of 'nav_bar_bloc.dart';

@immutable
sealed class NavBarState {
  final int index;

  const NavBarState({required this.index});
}

final class NavBarInitial extends NavBarState {
  const NavBarInitial() : super(index: 0);

  List<Object> get props => [index];
}

final class NavBarUpdated extends NavBarState {
  const NavBarUpdated(int index) : super(index: index);

  List<Object> get props => [index];
}
