part of 'registered_system_bloc.dart';

@immutable
sealed class RegisteredSystemEvent {
  List<Object?> get props => [];
}

class FetchData extends RegisteredSystemEvent{}

class RefreshData extends RegisteredSystemEvent{}
