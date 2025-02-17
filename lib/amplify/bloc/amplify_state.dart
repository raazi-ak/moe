part of 'amplify_bloc.dart';

abstract class AmplifyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AmplifyInitial extends AmplifyState {}

class AmplifyLoading extends AmplifyState {}

class AmplifyLoaded extends AmplifyState {}

class AmplifyError extends AmplifyState {
  final String message;

  AmplifyError(this.message);

  @override
  List<Object?> get props => [message];
}
