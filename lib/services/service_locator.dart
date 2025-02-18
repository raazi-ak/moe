import 'package:get_it/get_it.dart';
import 'package:moe/services/connectivity/bloc/connectivity_bloc.dart';
import 'package:moe/services/connectivity/repos/connectivity_repository.dart';
import '../amplify/repos/amplify_repository.dart';
import '../amplify/bloc/amplify_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AmplifyRepository>(() => AmplifyRepository());
  getIt.registerFactory(() => AmplifyBloc(amplifyRepository: getIt<AmplifyRepository>()));
  getIt.registerLazySingleton<ConnectivityRepository>(() => ConnectivityRepository());
  getIt.registerFactory(() => ConnectivityBloc(connectivityRepository: getIt<ConnectivityRepository>()));
}
