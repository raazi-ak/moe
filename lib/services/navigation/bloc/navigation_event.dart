// Navigation Events
part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateTo extends NavigationEvent {
  final String routeName;
  final Object? arguments;

  const NavigateTo(this.routeName, {this.arguments});

  @override
  List<Object> get props => [routeName, arguments ?? ""];
}

class NavigateBack extends NavigationEvent {}
