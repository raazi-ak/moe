part of 'registered_system_bloc.dart';

@immutable
sealed class RegisteredSystemEvent {
  @override
  List<Object?> get props => [];
}

class FetchData extends RegisteredSystemEvent{}

class RefreshData extends RegisteredSystemEvent{}
