part of 'add_pannels_bloc.dart';

@immutable
sealed class AddPannelsState {}

class AddPannelsInitial extends AddPannelsState {
  final List<PannelModel> details;

  AddPannelsInitial({this.details = const []});
}
