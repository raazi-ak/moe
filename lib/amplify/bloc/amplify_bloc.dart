import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repos/amplify_repository.dart';

part 'amplify_event.dart';
part 'amplify_state.dart';

class AmplifyBloc extends Bloc<AmplifyEvent, AmplifyState> {
  final AmplifyRepository amplifyRepository;

  AmplifyBloc({required this.amplifyRepository}) : super(AmplifyInitial()) {
    on<InitializeAmplify>((event, emit) async {
      emit(AmplifyLoading());
      try {
        await amplifyRepository.configureAmplify();
        emit(AmplifyLoaded());
      } catch (e) {
        emit(AmplifyError("Failed to initialize Amplify: $e"));
      }
    });
  }
}
