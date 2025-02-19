// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moe/dashboard/repos/registered_systems/registered_systems_api.dart';

part 'registered_system_event.dart';
part 'registered_system_state.dart';

class RegisteredSystemBloc extends Bloc<RegisteredSystemEvent, RegisteredSystemState> {
  final RegisteredSystemsAPIRepo apiRepo;

  RegisteredSystemBloc(this.apiRepo) : super(RegisteredSystemInitial()) {
    on<FetchData>(_onFetchData);
    on<RefreshData>(_onFetchData);
  }

  Future<void> _onFetchData(RegisteredSystemEvent event, Emitter<RegisteredSystemState> emit) async {
    emit(RegisteredSystemLoading());
    try {
      final data = await apiRepo.fetchUserSystems(); // Call API
      final uniqueData = data?.toSet().toList();
      emit(RegisteredSystemLoaded(uniqueData));
    } catch (e) {
      emit(RegisteredSystemError("Failed to fetch data"));
    }
  }
}
