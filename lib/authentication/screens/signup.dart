import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:moe/authentication/widgets/adaptive_button.dart';
// import 'package:moe/services/themes.dart';

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

  bool isNameEmpty = false;
  bool isEmailInvalid = false;
  bool isPasswordInvalid = false;
  bool isPasswordMismatch = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validatePassword);
    confirmPasswordController.addListener(_validateConfirmPassword);
    emailController.addListener(_validateEmail);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    setState(() {
      isPasswordInvalid = !isPasswordValid(passwordController.text);
    });
  }

  void _validateConfirmPassword() {
    setState(() {
      isPasswordMismatch = passwordController.text != confirmPasswordController.text;
    });
  }

  void _validateEmail() {
    setState(() {
      isEmailInvalid = !isEmailValid(emailController.text);
    });
  }

  bool isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$');
    return emailRegExp.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[!@#\$&*])(?=.*[0-9]).{8,}\$');
    return passwordRegExp.hasMatch(password);
  }

  void _handleSignUp() {
    setState(() {
      isNameEmpty = nameController.text.isEmpty;
      isEmailInvalid = !isEmailValid(emailController.text);
      isPasswordInvalid = !isPasswordValid(passwordController.text);
      isPasswordMismatch = passwordController.text != confirmPasswordController.text;
    });

    if (!isNameEmpty && !isEmailInvalid && !isPasswordInvalid && !isPasswordMismatch) {
      setState(() => isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoading = false);
        // Navigate or show success message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final themeManager = ThemeManager.instance;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.07),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTextField(
                  controller: nameController,
                  hintText: "Name",
                  errorText: isNameEmpty ? "Field cannot be empty" : null),
              const SizedBox(height: 15),
              _buildTextField(
                  controller: emailController,
                  hintText: "Email",
                  errorText: isEmailInvalid ? "Enter a valid email address" : null),
              const SizedBox(height: 15),
              _buildTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                  errorText: isPasswordInvalid
                      ? "Password must contain an uppercase letter, a number, and a special character."
                      : null),
              const SizedBox(height: 15),
              _buildTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true,
                  errorText: isPasswordMismatch ? "Passwords do not match" : null),
              const SizedBox(height: 25),
              isLoading
                  ? _buildLoadingIndicator()
                  : AdaptiveButton(
                      text: "Sign Up",
                      isLarge: true,
                      onTap: _handleSignUp,
                      isError: isNameEmpty || isEmailInvalid || isPasswordInvalid || isPasswordMismatch,
                    ),
            ],
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
        const SizedBox(width: 10),
        const Icon(Icons.account_circle_outlined, size: 50),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: hintText,
        errorText: errorText,
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulseSync,
        colors: [Colors.blue],
      ),
    );
  }
}
