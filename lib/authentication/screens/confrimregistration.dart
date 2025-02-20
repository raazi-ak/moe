import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe/authentication/bloc/auth_bloc.dart';
import 'package:moe/authentication/widgets/adaptive_button.dart';
import 'package:moe/services/routes/app_routes.dart';

class ConfirmRegistrationModal extends StatefulWidget {
  const ConfirmRegistrationModal({super.key, required this.username});
  final String username;

  @override
  State<ConfirmRegistrationModal> createState() =>
      _ConfirmRegistrationModalState();
}

class _ConfirmRegistrationModalState extends State<ConfirmRegistrationModal> {
  final TextEditingController verificationCodeController =
      TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 60;
  bool canResendCode = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    verificationCodeController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      canResendCode = false;
      _secondsRemaining = 60;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        setState(() {
          canResendCode = true;
        });
      }
    });
  }

  void _confirmSignUp() {
    // Dispatch the confirm event with username and entered verification code.
    context.read<AuthBloc>().add(ConfirmSignUpRequested(
      email: widget.username,
      confirmationCode: verificationCodeController.text,
    ));
  }

  void _resendCode() {
    if (!canResendCode) return;
    context.read<AuthBloc>().add(
        ResendVerificationCodeRequested(email: widget.username));
    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          // Confirmation succeeded; close the modal.
          Navigator.pop(context, true);
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route)=> false );
        }
        // If there's an error, the builder below will display it.
      },
      builder: (context, state) {
        // Show loading indicator if the bloc is processing.
        bool isLoading = state is AuthLoading;
        String? errorMsg;
        if (state is AuthError) {
          errorMsg = state.errorMessage;
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Verify Your Email",
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Enter the verification code sent to your email",
                        style: GoogleFonts.roboto(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: verificationCodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Verification Code",
                          errorText: errorMsg,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : AdaptiveButton(
                              text: "Confirm",
                              isLarge: true,
                              onTap: _confirmSignUp,
                            ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: canResendCode ? _resendCode : null,
                        child: Text(
                          canResendCode
                              ? "Resend Code"
                              : "Resend in $_secondsRemaining s",
                          style: GoogleFonts.roboto(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
