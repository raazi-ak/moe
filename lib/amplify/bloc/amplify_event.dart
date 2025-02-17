part of 'amplify_bloc.dart';

abstract class AmplifyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeAmplify extends AmplifyEvent {}
