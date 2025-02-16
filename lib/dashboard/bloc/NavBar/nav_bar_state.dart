part of 'nav_bar_bloc.dart';

@immutable
sealed class NavBarState {
  final int index;

  NavBarState({required this.index});

}

final class NavBarInitial extends NavBarState {
  NavBarInitial() : super(index: 0);

  @override
  List<Object> get props => [index];
}

final class NavBarUpdated extends NavBarState{
  NavBarUpdated(int index) : super(index: index);

  @override
  List<Object> get props => [index];
}
