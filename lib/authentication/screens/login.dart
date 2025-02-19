import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
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
                    _buildTextField("Geben Sie Ihre E-Mail Adresse ein", theme),
                    const SizedBox(height: 20),
                    _buildLabel("Passwort", theme),
                    _buildPasswordField(theme),
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
      ),
    );
  }

  Widget _buildLabel(String text, ThemeData theme) {
    return Text(
      text,
      style: theme.textTheme.bodyLarge,
    );
  }

  Widget _buildTextField(String hintText, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
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
        Text(
          'Sie haben kein Konto? ',
          style: theme.textTheme.bodyMedium,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Anmelden',
            style: theme.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context, ThemeData theme) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      child: const Text("Anmeldung"),
    );
  }
}
