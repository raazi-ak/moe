import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moe/amplify/bloc/amplify_bloc.dart';
import 'package:moe/dashboard/bloc/Registered_Systems/registered_system_bloc.dart';
import 'package:moe/dashboard/repos/registered_systems/registered_systems_api.dart';
import 'package:moe/homescreen.dart';
import 'package:moe/services/connectivity/bloc/connectivity_bloc.dart';
// import 'package:moe/services/navigation/bloc/navigation_bloc.dart';
import 'package:moe/services/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AmplifyBloc>()..add(InitializeAmplify())),
        BlocProvider(create: (context) => getIt<ConnectivityBloc>()),
        BlocProvider(
          create: (context) => RegisteredSystemBloc(RegisteredSystemsAPIRepo()),
        ),
        // BlocProvider(create: (context) => getIt<NavigationBloc>()),
      ],
      child: MaterialApp(
        title: 'Amplify BLoC App',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('de'), // German
        ],
        home: const HomeScreen(),
      ),
    );
  }
}
