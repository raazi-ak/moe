
part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigationSuccess extends NavigationState {
  final String routeName;
  final Object? arguments;

  const NavigationSuccess(this.routeName, {this.arguments});

  @override
  List<Object> get props => [routeName, arguments ?? ""];
}
