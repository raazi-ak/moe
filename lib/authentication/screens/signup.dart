import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:moe/authentication/bloc/auth_bloc.dart';
import 'package:moe/authentication/widgets/adaptive_button.dart';
import 'package:moe/services/service_locator.dart';
import 'package:moe/authentication/screens/confrimregistration.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError("Please fill in all fields.");
      return;
    }
    if (password != confirmPassword) {
      _showError("Passwords do not match.");
      return;
    }
    context.read<AuthBloc>().add(SignUpRequested(email: email, password: password, name: name));
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showConfirmationModal(String email) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ConfirmRegistrationModal(username: email),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() => isLoading = true);
          } else {
            setState(() => isLoading = false);
          }

          if (state is AuthNeedsVerification) {
            _showConfirmationModal(state.email);
          } else if (state is AuthError) {
            _showError(state.errorMessage);
          }
        },
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildTextField(controller: nameController, hintText: "Name"),
                  _buildTextField(controller: emailController, hintText: "Email"),
                  _buildTextField(controller: passwordController, hintText: "Password", obscureText: true),
                  _buildTextField(controller: confirmPasswordController, hintText: "Confirm Password", obscureText: true),
                  const SizedBox(height: 25),
                  isLoading ? _buildLoadingIndicator() : AdaptiveButton(text: "Sign Up", onTap: _handleSignUp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Sign Up", style: GoogleFonts.roboto(fontSize: 34, fontWeight: FontWeight.w600)),
        const Icon(Icons.account_circle_outlined, size: 50),
      ],
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hintText, bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(border: const UnderlineInputBorder(), hintText: hintText),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: LoadingIndicator(indicatorType: Indicator.ballPulseSync, colors: [Colors.blue]),
    );
  }
}
