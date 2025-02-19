import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moe/onboarding/bloc/search_device/search_device_page.dart';
import 'package:moe/onboarding/screens/bluetooth_close_page.dart';
import 'package:moe/onboarding/util/utils.dart';


class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: MediaQuery.of(context).size.width * 0.09,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: InkWell(
          onTap: () async {
            (await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on)
                ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchDevicePage()))
                : Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Bluetooth_Close()));
          },
          child: Container(
            decoration: BoxDecoration(
                color: black,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Verbinde meinen Akku",
                style: fontStyling(
                  16.0,
                  FontWeight.w700,
                  white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 40,
            ),
            SvgPicture.asset("assets/images/deviceaddscreenappiconforlightmode.svg"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
            ),
            //sdsd
            Container(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: Image.asset("assets/images/invertoraloneimage.png")),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "schalte das Gerät ein\n",
                        style: fontStyling(
                          24.0,
                          FontWeight.w800,
                          black,
                        )),
                    const TextSpan(
                      text: "\n",
                    ),
                    TextSpan(
                        text: "Schalten Sie Ihr Batteriegerät ein, indem\n",
                        style: fontStyling(
                          14.0,
                          FontWeight.w400,
                          black,
                        )),
                    TextSpan(
                        text: "Sie  die Taste darauf drücken.",
                        style: fontStyling(
                          14.0,
                          FontWeight.w400,
                          black,
                        )),
                  ],
                ),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
