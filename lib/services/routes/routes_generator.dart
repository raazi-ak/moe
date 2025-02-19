import 'package:flutter/material.dart';
import 'package:moe/authentication/screens/login.dart';
import 'package:moe/authentication/screens/signup.dart';
import 'package:moe/dashboard/screens/dashboard_main.dart';
import 'package:moe/homescreen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashBoardMainScreen());
      // case AppRoutes.profile:
      //   return MaterialPageRoute(builder: (_) => const ProfileScreen());
      // case AppRoutes.settings:
      //   return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
