import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moe/dashboard/screens/dashboard_main.dart';
import 'package:moe/dashboard/screens/dashboard_values_screen.dart';

import 'package:provider/provider.dart';

import '../../onboarding/util/utils.dart';
import '../blocs/add_pannels_bloc.dart';
import '../models/pannel_model.dart';


class review_page extends StatefulWidget {
  const review_page({super.key});

  @override
  State<review_page> createState() => _review_pageState();
}

class _review_pageState extends State<review_page> {
  TextEditingController name_cont = TextEditingController();
  bool isTest = true;
  bool requriesMock = false;
  late PannelModel latestPanel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    latestPanel = (context.watch<AddPannelsBloc>().state as AddPannelsInitial).details.last;
  }

  @override
  Widget build(BuildContext context) {

    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    var scColor = Colors.white;
    var txColor = Colors.black;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scColor,
      appBar: AppBar(
        backgroundColor: scColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 19,
            color: txColor,
          ),
        ),
        leadingWidth: 50,
        // actions: [
        //   GestureDetector(
        //     onDoubleTap: () async {
        //       const String devPass = 'thisisnotapassword';
        //       final Textinp
        //       await showAdaptiveDialog(
        //         context: context,
        //         builder: (context) => AlertDialog.adaptive(
        //           content: Container(
        //             width: size.width * 0.8,
        //             height: size.height * 0.2,
        //             padding: EdgeInsets.all(6),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   "Enter Code",
        //                   style: GoogleFonts.roboto(
        //                       textStyle: TextStyle(
        //                           color: txColor,
        //                           fontSize: 20,
        //                           fontWeight: FontWeight.w600)),
        //                 ),
        //                 TextField()
        //               ],
        //             ),
        //           ),
        //           backgroundColor: scColor,
        //         ),
        //       );
        //     },
        //     child: Container(
        //       height: 30,
        //       width: 30,
        //       clipBehavior: Clip.antiAlias,
        //       decoration:
        //           BoxDecoration(borderRadius: BorderRadius.circular(50)),
        //       child: Center(child: Icon(Icons.developer_board)),
        //     ),
        //   ),
        //   SizedBox(
        //     width: size.width * 0.07,
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "HINZUFÜGEN",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 30,
                  color: txColor,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Text(
                "Übersicht",
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 40,
                  color: txColor,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Text(
                "Name",
                style: TextStyle(
                    fontSize: 18, color: txColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.007,
              ),
              Text(
                latestPanel.name,
                style: TextStyle(
                    fontSize: 16,
                    color: txColor,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "Standort",
                style: TextStyle(
                    fontSize: 18, color: txColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.007,
              ),
              Text(
                "Latitude: ${latestPanel.location?.lat.toStringAsFixed(6)} Longitude: ${latestPanel.location?.long.toStringAsFixed(6)}",
                style: TextStyle(
                    fontSize: 16,
                    color: txColor,
                    fontWeight: FontWeight.w300,
                    overflow: TextOverflow.ellipsis),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "Azimut",
                style: TextStyle(
                    fontSize: 18, color: txColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.007,
              ),
              Text(
                latestPanel.azimuth.toString(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: txColor,
                    overflow: TextOverflow.ellipsis),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "Neigung",
                style: TextStyle(
                    fontSize: 18, color: txColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.007,
              ),
              Text(
                latestPanel.tilt!.roundToDouble().toString(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: txColor,
                    overflow: TextOverflow.ellipsis),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                "Kapazität",
                style: TextStyle(
                    fontSize: 18, color: txColor, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.007,
              ),
              Text(
                "${latestPanel.capacity} W",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: txColor,
                    overflow: TextOverflow.ellipsis),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              GestureDetector(
                onTap: () async {
                  // print('systemId: ${addProvider.system_id}, '
                  //     'name: ${addProvider.name}, '
                  //     'address: dsds, '
                  //     'azimuth: ${addProvider.azimuth}, '
                  //     'angle: ${addProvider.tilt}, '
                  //     'latitude: ${double.parse(addProvider.location.lat.toStringAsFixed(2))}, '
                  //     'longitude: ${double.parse(addProvider.location.long.toStringAsFixed(2))}, '
                  //     'capacity: ${addProvider.capacity}');
                  //
                  // await S3PanelService().uploadPanels("${addProvider.system_id}.json", [
                  //   {
                  //     "systemId": addProvider.system_id,
                  //     "name": addProvider.name,
                  //     "address": "dsds",
                  //     "azimuth": addProvider.azimuth,
                  //     "angle": addProvider.tilt,
                  //     "latitude": double.parse(
                  //         addProvider.location.lat.toStringAsFixed(2)),
                  //     "longitude": double.parse(
                  //         addProvider.location.long.toStringAsFixed(2)),
                  //     "capacity": addProvider.capacity,
                  //     "battery_no": "${addProvider.bat_no}",
                  //     "panel_no": "${addProvider.pan_no}"
                  //   }
                  // ]);
                  // await DatabaseHelper().insertSystem(
                  //     systemId: addProvider.system_id,
                  //     name: addProvider.name,
                  //     address: "dsds",
                  //     azimuth: addProvider.azimuth,
                  //     angle: addProvider.tilt,
                  //     latitude: double.parse(
                  //         addProvider.location.lat.toStringAsFixed(2)),
                  //     longitude: double.parse(
                  //         addProvider.location.long.toStringAsFixed(2)),
                  //     capacity: addProvider.capacity,
                  //     battery_no: addProvider.bat_no,
                  //     panel_no: addProvider.pan_no);

                  context.read<AddPannelsBloc>().add(SubmitDetails());

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => DashBoardMainScreen()),
                        (Route<dynamic> route) => false, // This removes all previous routes
                  );
                },
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.062,
                  decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(40),
                    color: black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Nächste",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
