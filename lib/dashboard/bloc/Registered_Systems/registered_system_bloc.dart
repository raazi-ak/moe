import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moe/dashboard/repos/registered_systems/registered_systems_api.dart';

part 'registered_system_event.dart';
part 'registered_system_state.dart';

class RegisteredSystemBloc extends Bloc<RegisteredSystemEvent, RegisteredSystemState> {
  final Registered_Systems_API_Repo api_repo;

  RegisteredSystemBloc(this.api_repo) : super(RegisteredSystemInitial()) {
    on<FetchData>(_onFetchData);
    on<RefreshData>(_onFetchData);
  }

  Future<void> _onFetchData(RegisteredSystemEvent event, Emitter<RegisteredSystemState> emit) async {
    emit(RegisteredSystemLoading());
    try {
      final data = await api_repo.fetchUserSystems(); // Call API
      final uniqueData = data?.toSet().toList();
      emit(RegisteredSystemLoaded(uniqueData));
    } catch (e) {
      emit(RegisteredSystemError("Failed to fetch data"));
    }
  }
}
