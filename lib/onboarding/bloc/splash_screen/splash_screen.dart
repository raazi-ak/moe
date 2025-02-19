import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/splash_screen_cubit.dart';
import 'cubit/splash_screen_provider.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({
    required this.route,
    super.key,
  });

  final Route<dynamic> route;

  @override
  Widget build(BuildContext context) {
    return SplashScreenProvider(
      child: SplashScreenView(
        route: route,
      ),
    );
  }
}

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({required this.route, super.key});

  final Route<dynamic> route;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashScreenCubit, SplashScreenState>(
      listenWhen: (previous, current) {
        return previous.state != InitializationState.successful &&
            current.state == InitializationState.successful;
      },
      listener: (context, _) {
        Navigator.of(context).push(route);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
              height: 150,
              width: 150,
              child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
