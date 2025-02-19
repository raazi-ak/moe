import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe/dashboard/screens/dashboard_values_screen.dart';
import 'package:moe/onboarding/util/utils.dart';
import 'package:ble_connector/ble_connector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nineti_heimspeicher/nineti_heimspeicher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/fetch_provisioning.dart';


class Review_Exit extends StatefulWidget {
  WiFiConnectParameter param;
  final BLEDevice device;
  Review_Exit({super.key , required this.param , required this.device});

  @override
  State<Review_Exit> createState() => _Review_ExitState();
}

class _Review_ExitState extends State<Review_Exit> {
  String status = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prov_Stuff();
  }

  prov_Stuff() async{
    setState(() {
      status = "Connecting to Wifi";
    });

    try{
      await context.read<HeimspeicherSystem>().connectToWifi(widget.param);

      await Future.delayed(const Duration(seconds: 10));

      if(context.read<HeimspeicherSystem>().wifiStatusStream.value.toString() != "Connected"){
        throw(Error);
      }else{
        setState(() {
          status = "Provisioning...";
        });
      }
    }catch(e){
      print("ERROR");
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (_) => const ConnectionFailedScreen(),
        ),
      );

      await Future.delayed(const Duration(seconds: 5));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardValuesScreen(),
        ),
            (route) => false,
      );
    }
    singleFunctionCloudProvisioning(context, widget.device);

  }

  void singleFunctionCloudProvisioning(BuildContext context, BLEDevice device) async {
    final provisioningPackager = ProvisioningPackager();
    //final GetPutUserTable userApi = GetPutUserTable();
    String isDownloading = 'Downloading...';
    String deviceId = device.id.replaceAll(RegExp(r'[_: -]'), '').substring(0, 12).toUpperCase().replaceAllMapped(RegExp(r'.{2}'), (match) => '${match.group(0)}_').replaceAll(RegExp(r'_$'), '');

    try {
      // Fetch provisioning package
      await provisioningPackager
          .fetchProvisioningPackage(deviceId);

      print("Fool");
      print(device.id);
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      final filePath = sharedPreferences.getString('provisioningPath');
      if (filePath == null) {
        throw Exception('Provisioning path not found in shared preferences.');
      }
      final provisioningPackage = File(filePath);

      isDownloading = 'Successfully downloaded. Provisioning in progress...';

      // Read data from the provisioning package
      final provisioningData = provisioningPackage.readAsBytesSync();

      // Provision cloud connection
      final heimspeicher = context.read<HeimspeicherSystem>();
      heimspeicher.provisionCloudConnection(provisioningData);

      // Update the user table
      final String systemID = deviceId;
      //await userApi.putUserTableData(systemID);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cloud provisioning complete.'),
        ),
      );

      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (_) => const TemporaryScreen(),
        ),
      );

      await Future.delayed(const Duration(seconds: 5));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardValuesScreen(),
        ),
            (route) => false,
      );
    } catch (e) {
      // Handle errors
      isDownloading = 'Failed to download or provision: ${e.toString()}';
      //Fluttertoast.showToast(msg: e.toString());

      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (_) => ConnectionFailedScreen(),
        ),
      );

      await Future.delayed(const Duration(seconds: 5));

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardValuesScreen(),
        ),
            (route) => false,
      );

      //return;
    }

    // Optionally display the status
    final status =
        context.read<HeimspeicherSystem>().cloudProvisioningStatus.valueOrNull;
    print('Provisioning status: ${status ?? 'NO DATA'}');

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: black,
                    ),
                  )
              ),
            ),
            Text(
              status,
              style: fontStyling(
                16.0,
                FontWeight.w400,
                black,
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
      // body: ListView(
      //   children: [
      //     Card(
      //       child: ListTile(
      //         title: Text(data.toString()),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class TemporaryScreen extends StatelessWidget {
  const TemporaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 40,
            ),
            SvgPicture.asset("assets/images/deviceaddscreenappiconforlightmode.svg"),
            Expanded(
              child: SvgPicture.asset("assets/images/deviceconnectedtickforlightmode.svg"),
            ),
            Text(
              "Erfolgreich Gerät verbunden",
              style: fontStyling(
                25.0,
                FontWeight.w700,
                black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class ConnectionFailedScreen extends StatelessWidget {
  const ConnectionFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 40,
            ),
            SvgPicture.asset("assets/images/deviceaddscreenappiconforlightmode.svg"),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: SvgPicture.asset("assets/images/deviceconnectionunsuccessiconforlightmode.svg"),
            ),
            const SizedBox(
              height: 40,
            ),
            Text("Gerät nicht verbunden",
                style: fontStyling(
                  25.0,
                  FontWeight.w700,
                  black,
                )),
            const SizedBox(
              height: 40,
            ),
            solidColorMainUiButton(
                    () async {},
                "Erneut versuchen",
                black,
                white),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
