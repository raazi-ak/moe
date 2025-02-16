import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moe/dashboard/widgets/header_design.dart';
import 'package:moe/dashboard/widgets/monetary_widget.dart';
import 'package:moe/dashboard/widgets/multi_dev_header.dart';
import 'package:moe/dashboard/widgets/system_values_widget.dart';
import 'package:moe/dashboard/widgets/systems_tile_widget.dart';

import '../bloc/Registered_Systems/registered_system_bloc.dart';

class DashboardValuesScreen extends StatefulWidget {
  const DashboardValuesScreen({super.key});

  @override
  State<DashboardValuesScreen> createState() => _DashboardValuesScreenState();
}

class _DashboardValuesScreenState extends State<DashboardValuesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RegisteredSystemBloc>().add(RefreshData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: BlocBuilder<RegisteredSystemBloc, RegisteredSystemState>(
          builder: (context, state) {
            if (state is RegisteredSystemLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RegisteredSystemLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    HeaderDesign(),
                    SizedBox(
                      height: 20,
                    ),
                    MonetaryWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    (state.data!.length > 1) ? multi_dev_header() : Container(height: 0,),
                    (state.data!.length == 1)
                        ? SystemValuesWidget(id: state.data![0],)
                        : Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                              itemCount: state.data?.length,
                              itemBuilder: (context, index) {
                                return SystemsTileWidget(
                                    deviceID: state.data![index]);
                                //return ListTile(title: Text(state.data![index].toString()));
                              },
                            ),
                        ),
                  ],
                ),
              );
            } else if (state is RegisteredSystemError) {
              return Center(child: Text(state.errorMessage));
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<RegisteredSystemBloc>().add(FetchData());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
