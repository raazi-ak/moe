import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe/dashboard/screens/dashboard_values_screen.dart';
import 'package:moe/dashboard/screens/profile_screen.dart';
import '../bloc/NavBar/nav_bar_bloc.dart';
import '../widgets/nav_bar.dart';


class DashBoardMainScreen extends StatelessWidget {
  DashBoardMainScreen({super.key});

  final List<Widget> pages = const [
    DashboardValuesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.index],
          bottomNavigationBar: CustomBottomNavBar(),
        );
      },
    );
  }
}
