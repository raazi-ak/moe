import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/NavBar/nav_bar_bloc.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.account_circle_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    // final ThemeProperties themeProperties = ThemeProperties(context: context);
    // var scColor = isDarkMode ? ScaffoldColor().dark : ScaffoldColor().light;
    // var txColor = isDarkMode ? TextColor().dark : TextColor().light;

    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double iconSize = constraints.maxWidth * 0.08;

            return BottomAppBar(
              height: MediaQuery.of(context).size.height * 0.06, // Keep this height to avoid icon cropping
              //color: scColor,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                //decoration: BoxDecoration(color: scColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(_icons.length, (index) {
                    return IconButton(
                      iconSize: iconSize,
                      alignment: Alignment.topCenter, // Align icons to the top
                      padding: EdgeInsets.zero, // Remove extra padding
                      //splashColor: txColor.withOpacity(0.2),
                      onPressed: () {
                        context.read<NavBarBloc>().add(ChangeTab(index));
                      },
                      icon: Icon(
                        _icons[index],
                        // color: index == bottomNavController.currentIndex
                        //     ? themeProperties.txColor
                        //     : themeProperties.txColor.withOpacity(0.2),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
