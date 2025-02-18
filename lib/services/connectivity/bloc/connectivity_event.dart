part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckConnectivity extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;

  ConnectivityChanged(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}
