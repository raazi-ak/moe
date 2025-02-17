import 'package:get_it/get_it.dart';
import '../amplify/repos/amplify_repository.dart';
import '../amplify/bloc/amplify_bloc.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AmplifyRepository>(() => AmplifyRepository());
  getIt.registerFactory(() => AmplifyBloc(amplifyRepository: getIt<AmplifyRepository>()));
}
