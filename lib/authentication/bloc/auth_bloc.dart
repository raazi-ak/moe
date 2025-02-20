// auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moe/authentication/repos/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<ConfirmSignUpRequested>(_onConfirmSignUpRequested);
    on<ResendVerificationCodeRequested>(_onResendVerificationCodeRequested);
    on<SignInRequested>(_onSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<CheckSessionRequested>(_onCheckSessionRequested);
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
      );
      emit(AuthNeedsVerification(email: event.email));
    } catch (e) {
      if (e.toString().contains("User is not confirmed")) {
        emit(AuthNeedsVerification(email: event.email));
      } else {
        emit(AuthError(errorMessage: e.toString()));
      }
    }
  }

  Future<void> _onConfirmSignUpRequested(ConfirmSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.confirmSignUp(email: event.email, confirmationCode: event.confirmationCode);
      // After confirmation, user is expected to sign in.
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(const AuthError(errorMessage: "Invalid verification code or expired."));
    }
  }

  Future<void> _onResendVerificationCodeRequested(ResendVerificationCodeRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.resendConfirmationCode(email: event.email);
      emit(AuthNeedsVerification(email: event.email));
    } catch (e) {
      emit(const AuthError(errorMessage: "Failed to resend verification code."));
    }
  }

  Future<void> _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.signIn(email: event.email, password: event.password);
      emit(AuthAuthenticated());
    } catch (e) {
      if (e.toString().contains("User is not confirmed")) {
        emit(AuthNeedsVerification(email: event.email));
      } else {
        emit(AuthError(errorMessage: e.toString()));
      }
    }
  }

  Future<void> _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }

  Future<void> _onCheckSessionRequested(CheckSessionRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final isSignedIn = await authRepo.isUserLoggedIn();
      if (isSignedIn) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
    }
  }
}
