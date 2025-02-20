import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moe/authentication/bloc/auth_bloc.dart';
import 'package:moe/services/routes/app_routes.dart';
import 'package:moe/services/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>(),
        ),
        
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // Update loading state based on AuthBloc events
          if (state is AuthLoading) {
            setState(() => _isLoading = true);
          } else {
            setState(() => _isLoading = false);
          }

          if (state is AuthAuthenticated) {
            // Dispatch navigation event via NavigationBloc on successful authentication.
           Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (route)=> false);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              _buildMainContent(theme, isDarkMode),
              if (_isLoading) _buildLoadingOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(ThemeData theme, bool isDarkMode) {
    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Row(
                    children: [
                      Text(
                        'Log In',
                        style: theme.textTheme.headlineLarge,
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(
                        isDarkMode
                            ? "assets/images/darkmodeprofileicon.svg"
                            : "assets/images/lightmodeprofileicon.svg",
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _buildLabel("Deine E-Mail", theme),
                  _buildTextField("Geben Sie Ihre E-Mail Adresse ein", theme, _emailController),
                  const SizedBox(height: 20),
                  _buildLabel("Passwort", theme),
                  _buildPasswordField(theme, _passwordController),
                  const SizedBox(height: 150),
                  _buildSignUpOption(context, theme),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          Column(
            children: [
              _buildLoginButton(context, theme),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLabel(String text, ThemeData theme) {
    return Text(text, style: theme.textTheme.bodyLarge);
  }

  Widget _buildTextField(String hintText, ThemeData theme, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: theme.dividerColor, width: 1),
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField(ThemeData theme, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: theme.dividerColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Geben Sie Ihr Passwort ein",
                hintStyle: theme.textTheme.bodyMedium,
                border: InputBorder.none,
              ),
            ),
          ),
          Text(
            "Vergessen",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpOption(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sie haben kein Konto? ', style: theme.textTheme.bodyMedium),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
          child: Text('Anmelden', style: theme.textTheme.bodyLarge),
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context, ThemeData theme) {
    return ElevatedButton(
      onPressed: _isLoading
          ? null
          : () {
              final email = _emailController.text.trim();
              final password = _passwordController.text.trim();

              if (email.isNotEmpty && password.isNotEmpty) {
                context.read<AuthBloc>().add(SignInRequested(email: email, password: password));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Bitte füllen Sie alle Felder aus")),
                );
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      child: const Text("Anmeldung"),
    );
  }

  // Loading Overlay
  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black38,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
