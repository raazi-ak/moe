import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NextButtonBarComponent extends StatelessWidget {
  const NextButtonBarComponent({
    super.key,
    required this.size,
    required this.scColorInv,
    required this.txColorInv,
  });

  final Size size;
  final Color scColorInv;
  final Color txColorInv;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: size.height * 0.062,
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(40),
        color: scColorInv,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Nächste",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: txColorInv,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: size.height * 0.045,
            width: size.width * 0.097,
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                width: 3,
                color: txColorInv,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Icon(
                Icons.chevron_right_rounded,
                color: txColorInv,
              ),
            ),
          ),
        ],
      ),
    );
  }
}