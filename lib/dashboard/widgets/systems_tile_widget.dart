import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moe/services/themes.dart';

class SystemsTileWidget extends StatelessWidget {
  final String deviceID;
  const SystemsTileWidget({super.key , required this.deviceID});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeManager();
    return GestureDetector(
      onTap: () {
        // Show the detail view on item click
        //showDetailView(deviceProvider.devices[index].id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.only(
            top: 20.0, left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          color: theme.containerBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MOE',
                      style: TextStyle(color: theme.white),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Text(
                          deviceID,
                          style: TextStyle(color: theme.white),
                        ),
                        const SizedBox(width: 6.0),
                        SvgPicture.asset(
                          'assets/images/dashboardcrossarrow.svg',
                          height: 24.0,
                          width: 24.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/images/cont_pannel.svg',
              height: 90.0,
              width: 90.0,
            ),
          ],
        ),
      ),
    );
  }
}
