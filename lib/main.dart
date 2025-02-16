import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe/dashboard/bloc/Registered_Systems/registered_system_bloc.dart';
import 'package:moe/dashboard/repos/registered_systems/registered_systems_api.dart';
import 'package:moe/dashboard/screens/dashboard_main.dart';
import 'package:moe/theme.dart';
import 'dashboard/bloc/NavBar/nav_bar_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavBarBloc(),
        ),
        BlocProvider(
          create: (context) => RegisteredSystemBloc(Registered_Systems_API_Repo()),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeManager.lightTheme,
        darkTheme: ThemeManager.darkTheme,
        themeMode: ThemeMode.system,

        supportedLocales: [
          Locale('en'), // English
          Locale('de'), // German
        ],
        home: DashBoardMainScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.helloWorld),
      ),
    );
  }
}
