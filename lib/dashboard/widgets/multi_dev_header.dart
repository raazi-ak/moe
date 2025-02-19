import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moe/services/themes.dart';

Widget multiDevHeader() {
  // SVG Paths
  const String productionSvgPath = 'assets/images/dashboardpaneliamge.svg';
  const String consumptionSvgPath = 'assets/images/multicolorhouse.svg';
  const String batterySvgPath = 'assets/images/dashboardcellimage.svg';

  // Text Data
  const String productionTextSmall = "PRODUKTION";

  const String consumptionTextSmall = "VERBRAUCH";

  const String batteryTextSmall = "LADEZUSTAND";

  final theme = ThemeManager();

  final String batteryTextLarge = "0 %";
  final String productionTextLarge = "0  WATT";
  final String consumptionTextLarge = "0 WATT";

  return Container(
    padding: const EdgeInsets.all(15.0),
    decoration: BoxDecoration(
      color: theme.containerBlack,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top left text
        Text(
          "AKTUELL",
        ),
        const SizedBox(height: 16.0),

        // Row of SVGs with text below each
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSvgColumn(productionSvgPath, productionTextSmall, productionTextLarge),
            buildSvgColumn(consumptionSvgPath, consumptionTextSmall, consumptionTextLarge),
            buildSvgColumn(batterySvgPath, batteryTextSmall, batteryTextLarge),
          ],
        ),
      ],
    ),
  );
}

Column buildSvgColumn(String svgPath, String textSmall, String textLarge) {
  List<String> largeTextParts = textLarge.split(' ');

  return Column(
    children: [
      // SVG icon
      SvgPicture.asset(
        svgPath,
        height: 70.0, // Customize height
        width: 70.0, // Customize width
      ),
      const SizedBox(height: 8.0), // Space between SVG and text

      // RichText with smaller and bigger text
      RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: '$textSmall\n', // Smaller text
            ),
            TextSpan(
              text: largeTextParts.isNotEmpty ? largeTextParts[0] : '', // The large number
            ),
            TextSpan(
              text: largeTextParts.length > 1 ? ' ${largeTextParts[1]}' : '', // The smaller unit,
            ),
          ],
        ),
      ),
    ],
  );
}
