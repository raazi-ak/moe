import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moe/add_pannels/screens/name_page.dart';
import 'package:moe/dashboard/repos/dashboard_values/system_model.dart';
import 'package:moe/theme.dart';

import '../bloc/DashBoard_Data/dashboard_data_bloc.dart';
import '../repos/dashboard_values/dashboard_values_api.dart';

class SystemValuesWidget extends StatefulWidget {
  String id;
  SystemValuesWidget({super.key, required this.id});

  @override
  State<SystemValuesWidget> createState() => _SystemValuesWidgetState();
}

class _SystemValuesWidgetState extends State<SystemValuesWidget> {
  late DashboardDataBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final repository = SystemWebSocketRepository(System(
        id: widget.id,
        batteries: [],
        inverter: Inverter(id: "", busPower: ""),
        solarPanels: []));
    _bloc = DashboardDataBloc(repository)..add(ConnectWebSocket());
  }
  @override
  void dispose() {
    //_bloc.close();
    super.dispose();
  }
  Map<String, dynamic> _processData(Map<String, dynamic> rawData) {
    // Ensure "Data" exists and is a List
    if (!rawData.containsKey("Data") || rawData["Data"] is! List) {
      throw Exception("Invalid data format: 'Data' key is missing or not a list");
    }

    List<dynamic> dataEntries = rawData["Data"];
    if (dataEntries.isEmpty) return {};

    // Ensure "Components" key exists inside the first entry
    if (!dataEntries[0].containsKey("Components") || dataEntries[0]["Components"] is! List) {
      throw Exception("Invalid data format: 'Components' key is missing or not a list");
    }

    List<dynamic> components = dataEntries[0]["Components"];

    Map<String, dynamic> result = {
      "Inverter": {},
      "Solars": {"total_voltage": 0.0, "total_current": 0.0, "total_bus_power": 0.0, "all_other": []},
      "Batteries": {"total_state_of_charge": 0.0, "total_bus_power": 0.0, "all_other": []}
    };

    for (var component in components) {
      if (!component.containsKey("Component") || !component.containsKey("Data")) {
        continue; // Skip invalid entries
      }

      String componentName = component["Component"];

      // Ensure "Data" inside Component is properly formatted
      dynamic rawComponentData = component["Data"];
      if (rawComponentData is String) {
        rawComponentData = jsonDecode(rawComponentData);
      }
      if (rawComponentData is! List) {
        throw Exception("Invalid format: 'Data' inside Component is not a list.");
      }
      List<dynamic> componentData = rawComponentData;

      List<String> splitName = componentName.split("_");
      String type = splitName[0]; // Inverter, Solar, Battery
      String id = splitName.length > 1 ? splitName[1] : "";

      double totalBusPower = 0.0;
      double totalVoltage = 0.0;
      double totalCurrent = 0.0;
      double totalStateOfCharge = 0.0;
      Map<String, dynamic> processedComponent = {"id": id};

      for (var entry in componentData) {
        if (entry is! Map<String, dynamic>) continue; // Ensure each entry is a Map

        if (entry.containsKey("busPower")) {
          totalBusPower += (entry["busPower"] as num).toDouble();
          processedComponent["busPower"] = totalBusPower;
        }
        if (entry.containsKey("pvVoltage")) {
          totalVoltage += (entry["pvVoltage"] as num).toDouble();
          processedComponent["pvVoltage"] = entry["pvVoltage"];
        }
        if (entry.containsKey("pvCurrent")) {
          totalCurrent += (entry["pvCurrent"] as num).toDouble();
          processedComponent["pvCurrent"] = entry["pvCurrent"];
        }
        if (entry.containsKey("stateOfCharge")) {
          totalStateOfCharge += (entry["stateOfCharge"] as num).toDouble();
          processedComponent["stateOfCharge"] = entry["stateOfCharge"];
        }
      }

      if (type == "Inverter") {
        result["Inverter"] = {"id": id, "total_bus_power": totalBusPower.abs()};
      } else if (type == "Solar") {
        result["Solars"]["total_voltage"] += totalVoltage;
        result["Solars"]["total_current"] += totalCurrent;
        result["Solars"]["total_bus_power"] += totalBusPower;
        result["Solars"]["all_other"].add(processedComponent);
      } else if (type == "Battery") {
        result["Batteries"]["total_state_of_charge"] += totalStateOfCharge * 100;
        result["Batteries"]["total_bus_power"] += totalBusPower;
        result["Batteries"]["all_other"].add(processedComponent);
      }
    }

    return result;
  }


  @override
  Widget build(BuildContext context) {
    final Theme = ThemeManager();
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<DashboardDataBloc, DashboardDataState>(
        builder: (context, state) {
          if (state is SystemDataLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SystemDataLoaded) {
            print(state.data);
            final formatted_data = _processData(state.data);
            print("POST FORMATTING======================================================");
            print(formatted_data);
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Theme.containerBlack,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // (systems.isNotEmpty)
                      //     ? GestureDetector(
                      //         onTap: () {
                      //           print(widget.selec_id);
                      //           Navigator.pushNamed(context, '/addModule',
                      //                   arguments: widget.selec_id)
                      //               .then((_) {
                      //             setState(() {
                      //               get_pannels();
                      //             });
                      //           });
                      //         },
                      //         child: SvgPicture.asset(
                      //           "assets/images/dashboardpaneliamge.svg",
                      //           height: 90,
                      //           width: 90,
                      //         ),
                      //       )
                      //     :
                      GestureDetector(
                        onTap: () {
                          //print(formatted_data);
                          //print(widget.selec_id);
                          // print(2);
                          // Navigator.pushNamed(context, '/addModule',
                          //         arguments: widget.selec_id)
                          //     .then((_) {
                          //   setState(() {
                          //     get_pannels();
                          //   });
                          // });
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => name_page(sys_id: widget.id, pan_no: 0, bat_no: 0)));
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                            color: Colors.black38, // Button background color
                            shape: BoxShape.circle,
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'ADD CELL',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            "AKTUELLE \nPRODUKTION",
                            style: TextStyle(
                              color: Theme.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              //Text(totalPowMppt.toString(),),
                              Text(
                                "${formatted_data["Inverter"]["total_bus_power"]}",
                                style: TextStyle(
                                  color: Theme.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              const SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "WATT",
                                  style: TextStyle(
                                    color: Theme.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 240,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 20,
                          child: Image.asset(
                            "assets/images/whiteverticalline.gif",
                            height: 240,
                          ),
                        ),
                        Positioned(
                          left: 50,
                          child: Image.asset(
                            "assets/images/dashboardblueline.gif",
                            height: 110,
                          ),
                        ),
                        Positioned(
                          left: 50,
                          bottom: 0,
                          child: Image.asset(
                            "assets/images/dashboardgreenline.gif",
                            height: 115,
                          ),
                        ),
                        Positioned(
                          left: 125,
                          top: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () async {
                              // await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => CurrentConsumptionScreen(
                              //           inverter: system.inverter, avg_pow: powInv!),
                              //
                              //       ///Navigate to current consumption screen
                              //     )).then((_) {
                              //   setState(() {
                              //     shelly_phase_power();
                              //   });
                              // });
                              // setState(() {});
                            },
                            child: SvgPicture.asset(
                              "assets/images/multicolorhouse.svg",
                              height: 90,
                              width: 90,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 213,
                          top: 0,
                          bottom: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "AKTUELLER \nVERBRAUCH",
                                style: TextStyle(
                                  color: Theme.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2.5),
                                    child: Text(
                                      // ((powInv ?? 0.0) + shell_pow)
                                      //     .toStringAsFixed(2),
                                      (0.0).toStringAsFixed(2),
                                      style: TextStyle(
                                        color: Theme.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "WATT",
                                      style: TextStyle(
                                        color: Theme.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 70,
                          top: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text("${(batteryPow - powInv!).abs()} WATT",
                              //         ),
                              Text(
                                "0.0 WATT",
                                style: TextStyle(
                                  color: Theme.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 70,
                          top: 145,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Text(
                              //         "$batteryPow WATT",
                              //       ),

                              Text(
                                "0 WATT",
                                style: TextStyle(
                                  color: Theme.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 5,
                          top: 0,
                          bottom: 0,
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text("${(totalPowMppt - (batteryPow - powInv!).abs()).abs()} WATT",),
                                Text(
                                  "0 WATT",
                                  style: TextStyle(
                                    color: Theme.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     CupertinoPageRoute(
                          //       builder: (context) => BatteryCharegeStatusScreen(
                          //         batteries: system.batteries,
                          //         average_batt: batteryPow,
                          //       ),
                          //     ));

                          ///Navigate to battery charging status screen
                        },
                        child: SvgPicture.asset(
                          "assets/images/dashboardcellimage.svg",
                          height: 90,
                          width: 90,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        children: [
                          Text(
                            "LADEZUSTAND \nBATTERIE",
                            style: TextStyle(
                              color: Theme.white,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Text(averageBatteryPercentage.toString(),
                              //       ),
                              Text(
                                "${formatted_data["Batteries"]["total_state_of_charge"]}",
                                style: TextStyle(color: Theme.white , fontSize: 20 , fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  "%",
                                  style: TextStyle(color: Theme.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          } else if (state is SystemDataError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return Container(
          );
        },
      ),
    );
  }
}
