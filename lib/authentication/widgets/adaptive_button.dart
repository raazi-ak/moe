import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moe/services/themes.dart';


class AdaptiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLarge;
  final bool isError;

  const AdaptiveButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLarge = false,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isError
        ? Colors.red[700]
        : isDarkMode
            ? ThemeManager.instance.white
            : ThemeManager.instance.black;
    final textColor = isError
        ? Colors.white
        : isDarkMode
            ? ThemeManager.instance.black
            : ThemeManager.instance.white;

    return GestureDetector(
      onTap: isError ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: isLarge ? 60 : 50,
        decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(40),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: textColor,
                  fontSize: isLarge ? 18 : 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.solid, width: 3, color: textColor),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: textColor,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
