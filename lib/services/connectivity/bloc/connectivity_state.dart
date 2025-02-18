part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  @override
  List<Object> get props => [];
}

class ConnectivityLoading extends ConnectivityState {}

class ConnectivityOnline extends ConnectivityState {}

class ConnectivityOffline extends ConnectivityState {}
