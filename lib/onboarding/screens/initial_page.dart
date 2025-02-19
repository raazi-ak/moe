import 'package:flutter/material.dart';
import 'package:moe/onboarding/screens/description_page.dart';

import '../bloc/initializable_provider.dart';
import '../bloc/splash_screen/splash_screen.dart';
import '../services/service_provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return ServiceProvider(
      child: InitializableProvider(
        child: SplashScreenPage(
            route: MaterialPageRoute(
              builder: (c) => const DescriptionPage(),
            ),
          ),
        ),
      );
  }
}
