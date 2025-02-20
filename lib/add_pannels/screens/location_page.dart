import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:moe/onboarding/util/utils.dart';

import '../blocs/add_pannels_bloc.dart';
import '../models/pannel_model.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/nav_button.dart';
import 'angles.dart';


class location_page extends StatefulWidget {
  const location_page({super.key});

  @override
  State<location_page> createState() => _location_pageState();
}

class _location_pageState extends State<location_page> {
  bool isLoading = false;
  String _locationMessage = "";
  DeviceLocation location = DeviceLocation(lat: 0.0, long: 0.0);
  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Location permissions are denied";
      });
      return;
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String address =
          await _getAddressFromLatLng(position.latitude, position.longitude);

      setState(() {
        _locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        location.lat = position.latitude;
        location.long = position.longitude;
        loc_cont.text = address;
      });
    }
  }
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

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return "${place.street}, ${place.postalCode}, ${place.locality}, ${place.country}";
    }
    return "No address available";
  }

  TextEditingController loc_cont = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 19,
            color: Colors.black,
          ),
        ),
        leadingWidth: 50,
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
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                "Wo befindet sich die Anlage?",
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 3,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              InkWell(
                enableFeedback: false,
                focusColor: Colors.transparent,
                onTap: () async {
                  _getCurrentLocation();
                  await Future.delayed(Durations.long4);
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (_) => const Angles()));
                },
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )),
                  alignment: Alignment.center,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: black,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: black,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              "Automatische Erkennung",
                              style: TextStyle(
                                fontSize: 16,
                                color: black,
                              ),
                            )
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "-----------  ",
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                  Text(
                    "oder",
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                  Text(
                    "  ----------",
                    style: TextStyle(
                      color: black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              custom_text_field(
                txt_cont: loc_cont,
                label: "Adresse",
              ),
              SizedBox(
                height: size.height * 0.27,
              ),
              GestureDetector(
                onTap: () {
                  //addProvider.setLocation(location);
                  // while (addProvider.location.lat == 0.0 ||
                  //     addProvider.location.long == 0.0) {
                  //   setState(() {
                  //     isLoading = true;
                  //   });
                  // }

                  context.read<AddPannelsBloc>().add(
                    UpdateDetail(
                      PannelModel(
                          system_id: latestPanel.system_id,
                          name: latestPanel.name,
                        location: location,
                          pan_no: latestPanel.pan_no,
                          bat_no: latestPanel.bat_no
                      )
                    )
                  );
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const Angles()));
                },
                child: isLoading
                    ? Container(
                        width: size.width * 0.8,
                        height: size.height * 0.062,
                        decoration: BoxDecoration(
                          border: Border.all(style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(40),
                          color: black,
                        ),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: black,
                        )),
                      )
                    : NextButtonBarComponent(
                        size: size,
                        scColorInv: black,
                        txColorInv: white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
