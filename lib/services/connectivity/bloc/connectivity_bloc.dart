import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repos/connectivity_repository.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityRepository connectivityRepository;

  ConnectivityBloc({required this.connectivityRepository}) : super(ConnectivityLoading()) {
    on<CheckConnectivity>((event, emit) async {
      bool isConnected = await connectivityRepository.checkInitialConnection();
      emit(isConnected ? ConnectivityOnline() : ConnectivityOffline());
    });

    connectivityRepository.connectivityStream.listen((isConnected) {
      add(ConnectivityChanged(isConnected));
    });

    add(CheckConnectivity());
  }

  @override
  Future<void> close() {
    connectivityRepository.dispose();
    return super.close();
  }
}
