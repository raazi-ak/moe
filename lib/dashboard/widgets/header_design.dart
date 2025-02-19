import 'package:flutter/material.dart';

class HeaderDesign extends StatelessWidget {
  const HeaderDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      minimum: const EdgeInsets.only(top: 20, left: 5, right: 5),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: PopupMenuButton<String>(
              //color: !isDarkMode ? black : white,
              onSelected: (value) {
                if (value == "newScreen") {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (_) =>
                  //       const Shelly_Home()), // Replace with your new screen widget
                  // );
                }
              },
              offset: const Offset(0, 40), // Adjust to position menu below text
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  value: "newScreen",
                  child: Text(
                    "Shelly Devices",
                  ),
                ),
              ],
              child: Row(
                children: [
                  Text(
                    "DEIN MOE SYSTEM",
                    style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_drop_down,
                    //color: isDarkMode ? white : black,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            // onDoubleTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (_) => const UserAttributesScreen()));
            // },
            // onLongPress: () async {
            //   await userAuthProvider.signOutCurrentUser();
            //   Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (_) => const LoginPage()),
            //         (Route<dynamic> route) => false,
            //   );
            // },
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
              Navigator.pushNamed(context, '/onboard_app');
            },
            child: Icon(
              Icons.add_circle_outline,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
