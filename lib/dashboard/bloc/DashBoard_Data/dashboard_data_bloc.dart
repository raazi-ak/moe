// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repos/dashboard_values/dashboard_values_api.dart';

part 'dashboard_data_event.dart';
part 'dashboard_data_state.dart';

class DashboardDataBloc extends Bloc<DashboardDataEvent, DashboardDataState> {
  final SystemWebSocketRepository repository;
  final Map<String, dynamic> _latestComponents = {};

  DashboardDataBloc(this.repository) : super(DashboardDataInitial()) {
    on<ConnectWebSocket>((event, emit) async {
      emit(SystemDataLoading());
      try {
        repository.connectWebSocket();
        repository.dataStream.listen((data) {
          add(NewDataReceived(data));
        });
      } catch (e) {
        emit(SystemDataError("WebSocket connection failed."));
      }
    });

    on<NewDataReceived>((event, emit) {
      final newData = event.data;
      if (newData["Data"] != null && newData["Data"].isNotEmpty) {
        final latestTimestamp = newData["Data"][0]["Timestamp"];
        final newComponents = newData["Data"][0]["Components"];

        for (var component in newComponents) {
          final componentName = component["Component"];
          _latestComponents[componentName] = component; // Update component
        }

        // Emit updated state with full merged data
        emit(SystemDataLoaded({
          "Data": [
            {
              "Timestamp": latestTimestamp,
              "Components": _latestComponents.values.toList(),
            }
          ]
        }));
      }
    });
  }

  @override
  Future<void> close() {
    repository.closeConnection();
    return super.close();
  }
}
