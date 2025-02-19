import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe/onboarding/bloc/splash_screen/cubit/splash_screen_cubit.dart';
import 'package:provider/single_child_widget.dart';

import '../../initializable_provider.dart';

class SplashScreenProvider extends SingleChildStatelessWidget {
  const SplashScreenProvider({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) => buildWithChild(context, child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    final get = context.read;

    return BlocProvider(
      create: (context) =>
          SplashScreenCubit(initializables: get<Initializables>())
            ..initialize(),
      child: child,
    );
  }
}
