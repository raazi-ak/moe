// auth_state.dart
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthNeedsVerification extends AuthState {
  final String email;
  const AuthNeedsVerification({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthError extends AuthState {
  final String errorMessage;
  const AuthError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
