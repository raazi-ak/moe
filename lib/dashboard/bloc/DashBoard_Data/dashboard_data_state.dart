part of 'dashboard_data_bloc.dart';

@immutable
sealed class DashboardDataState {}

final class DashboardDataInitial extends DashboardDataState {}

class SystemDataLoading extends DashboardDataState {}

class SystemDataLoaded extends DashboardDataState {
  final Map<String, dynamic> data;
  SystemDataLoaded(this.data);
}

class SystemDataError extends DashboardDataState {
  final String message;
  SystemDataError(this.message);
}