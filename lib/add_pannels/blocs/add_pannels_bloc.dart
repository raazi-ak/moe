import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moe/add_pannels/models/pannel_model.dart';

part 'add_pannels_event.dart';
part 'add_pannels_state.dart';

class AddPannelsBloc extends Bloc<AddPannelsEvent, AddPannelsState> {
  AddPannelsBloc() : super(AddPannelsInitial()) {
    on<AddDetail>((event, emit) {
      if (state is AddPannelsInitial) {
        final currentState = state as AddPannelsInitial;
        emit(AddPannelsInitial(details: List.from(currentState.details)..add(event.detail)));
      }
    });

    on<UpdateDetail>((event, emit) {
      if (state is AddPannelsInitial) {
        final currentState = state as AddPannelsInitial;

        // Replace the last added panel with the updated one
        List<PannelModel> updatedList = List.from(currentState.details);
        updatedList[updatedList.length - 1] = event.updatedDetail;

        emit(AddPannelsInitial(details: updatedList));
      }
    });


    on<SubmitDetails>((event, emit) {
      if (state is AddPannelsInitial) {
        final currentState = state as AddPannelsInitial;
        print("Details submitted: ${currentState.details}");
      }
    });

    on<ClearDetails>((event, emit) {
      emit(AddPannelsInitial()); // Clears the details after submission
    });
  }
}
