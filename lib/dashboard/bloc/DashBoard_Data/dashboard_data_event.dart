part of 'dashboard_data_bloc.dart';

@immutable
sealed class DashboardDataEvent {}

class ConnectWebSocket extends DashboardDataEvent {}

class NewDataReceived extends DashboardDataEvent {
  final Map<String, dynamic> data;
  NewDataReceived(this.data);
}
