
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';
part 'navigation_event.dart';


class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationBloc(this.navigatorKey) : super(NavigationInitial()) {
    on<NavigateTo>((event, emit) {
      navigatorKey.currentState?.pushNamed(event.routeName, arguments: event.arguments);
      emit(NavigationSuccess(event.routeName, arguments: event.arguments));
    });

    on<NavigateBack>((event, emit) {
      navigatorKey.currentState?.pop();
      emit(NavigationInitial());
    });
  }
}
