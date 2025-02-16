part of 'registered_system_bloc.dart';

@immutable
sealed class RegisteredSystemState {
  @override
  List<Object?> get props => [];
}

final class RegisteredSystemInitial extends RegisteredSystemState {}

final class RegisteredSystemLoading extends RegisteredSystemState {}

final class RegisteredSystemLoaded extends RegisteredSystemState {
  final List<String>? data;

  RegisteredSystemLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class RegisteredSystemError extends RegisteredSystemState {
  final String errorMessage;

  RegisteredSystemError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}