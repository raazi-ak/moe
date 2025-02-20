// auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}

class ConfirmSignUpRequested extends AuthEvent {
  final String email;
  final String confirmationCode;

  const ConfirmSignUpRequested({
    required this.email,
    required this.confirmationCode,
  });

  @override
  List<Object?> get props => [email, confirmationCode];
}

class ResendVerificationCodeRequested extends AuthEvent {
  final String email;

  const ResendVerificationCodeRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthEvent {}

class CheckSessionRequested extends AuthEvent {}
