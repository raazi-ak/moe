import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moe/add_pannels/screens/review_page.dart';

import '../../onboarding/util/utils.dart';
import '../blocs/add_pannels_bloc.dart';
import '../models/pannel_model.dart';
import '../widgets/nav_button.dart';

class Capacity extends StatefulWidget {
  const Capacity({super.key});

  @override
  State<Capacity> createState() => _CapacityState();
}

class _CapacityState extends State<Capacity> {
  TextEditingController? capacityController = TextEditingController();
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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var scColor = Colors.white;
    var txColor = Colors.black;
    final size = MediaQuery.of(context).size;

    bool isInputNumeric(String input) {
      // Check if the input contains only numbers
      return RegExp(r'^[0-9]+$').hasMatch(input);
    }

    return Scaffold(
        backgroundColor: scColor,
        appBar: AppBar(
          toolbarHeight: size.height * 0.0912,
          backgroundColor: scColor,
          leading: IconButton(
            iconSize: 32,
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.chevron_left_rounded,
              size: 28,
            ),
            color: txColor,
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(18),
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "HINZUFÜGEN",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                color: txColor)),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                        child: Text(
                          "Wie hoch ist die maximale Erzeugungskapazität?",
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: txColor)),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                        child: Center(
                          child: TextField(
                            controller: capacityController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                capacityController?.text = value;
                              });
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide()),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: txColor)),
                                hintText: " Kapazität",
                                focusColor: txColor,
                                hintStyle: GoogleFonts.roboto(
                                    textStyle: TextStyle(color: txColor))),
                            cursorColor: txColor,
                            showCursor: true,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(color: txColor)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.37,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(capacityController!.text.isNotEmpty){
                            if(isInputNumeric(capacityController!.text)){
                              //addProvider.setCapacity(capacityController!.text);
                              context.read<AddPannelsBloc>().add(
                                  UpdateDetail(
                                      PannelModel(
                                          system_id: latestPanel.system_id,
                                          name: latestPanel.name,
                                          location: latestPanel.location,
                                          azimuth: latestPanel.azimuth,
                                          tilt: latestPanel.tilt,
                                          capacity: capacityController?.text,
                                          pan_no: latestPanel.pan_no,
                                          bat_no: latestPanel.bat_no
                                      )
                                  )
                              );
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => const review_page()));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Please enter correctly.'),
                                duration: Duration(seconds: 5),
                              ));
                            }
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Please enter correctly.'),
                              duration: Duration(seconds: 5),
                            ));
                          }
                        },
                        child: NextButtonBarComponent(
                            size: size,
                            scColorInv: black,
                            txColorInv: white),
                      )
                    ]),
              ),
            )));
  }
}
