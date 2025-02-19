import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moe/services/themes.dart';


class MonetaryWidget extends StatelessWidget {
  const MonetaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeManager();

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const MonetarySavingsOverviewScreen(),
        //     ));
        ///navigate to monetary saving screen
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: theme.containerBlack, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text("GESAMT",  style: TextStyle(color: theme.white , fontSize: 12.0, fontWeight : FontWeight.w300 ),),
              const Spacer(),
              SvgPicture.asset(
                "assets/images/dashboardcrossarrow.svg",
                height: 24,
                width: 24,
              )
            ]),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("MONETÄRE",  style: TextStyle(color: theme.white ,  fontSize: 22.0, fontWeight : FontWeight.w700 ),),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "4.800",  style: TextStyle(color: theme.white ,  fontSize: 22.0, fontWeight : FontWeight.w700  ),
                       ),
                      TextSpan(
                        text: "  kwH",  style: TextStyle(color: theme.white ,  fontSize: 14.0, fontWeight : FontWeight.w300 ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("EINSPARUNG" ,  style: TextStyle(color: theme.white , fontSize: 22.0, fontWeight : FontWeight.w700 ),),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "1.900" ,  style: TextStyle(color: theme.white ,  fontSize: 22.0, fontWeight : FontWeight.w700 ),
                      ),
                      TextSpan(
                        text: "  €" ,  style: TextStyle(color: theme.white ,  fontSize: 14.0, fontWeight : FontWeight.w300 ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
