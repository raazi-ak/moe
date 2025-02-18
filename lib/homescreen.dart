import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'amplify/bloc/amplify_bloc.dart';

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
              return CircularProgressIndicator();
            } else if (state is AmplifyLoaded) {
              return Text(AppLocalizations.of(context)!.amplifyInitialized);
            } else if (state is AmplifyError) {
              return Text(AppLocalizations.of(context)!.errorMessage(state.message),
                  style: TextStyle(color: Colors.red));
            }
            return Text(AppLocalizations.of(context)!.initializing);
          },
        ),
      ),
    );
  }
}
