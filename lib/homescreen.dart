// import 'package:amplify_flutter/amplify_flutter.dart' as amplify;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moe/services/navigation/bloc/navigation_bloc.dart';
import 'package:moe/services/routes/app_routes.dart';
import 'package:moe/amplify/bloc/amplify_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.amplifyApp)),
      body: Center(
        child: BlocBuilder<AmplifyBloc, AmplifyState>(
          builder: (context, state) {
            if (state is AmplifyLoading) {
              return const CircularProgressIndicator();
            } else if (state is AmplifyLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.amplifyInitialized),
                  const SizedBox(height: 20),
                  _buildNavigationButton(context, "Authentication", AppRoutes.login),
                  _buildNavigationButton(context, "Dashboard", AppRoutes.dashboard),
                ],
              );
            } else if (state is AmplifyError) {
              return Text(
                AppLocalizations.of(context)!.errorMessage(state.message),
                style: const TextStyle(color: Colors.red),
              );
            }
            return Text(AppLocalizations.of(context)!.initializing);
          },
        ),
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String title, String route) {
    return ElevatedButton(
      onPressed: () {
        context.read<NavigationBloc>().add(NavigateTo(route));
      },
      child: Text(title),
    );
  }
}
