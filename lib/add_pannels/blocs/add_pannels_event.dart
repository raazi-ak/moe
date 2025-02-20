part of 'add_pannels_bloc.dart';

@immutable
sealed class AddPannelsEvent {}

class AddDetail extends AddPannelsEvent {
  final PannelModel detail;
  AddDetail(this.detail);
}

class UpdateDetail extends AddPannelsEvent {
  final PannelModel updatedDetail;
  UpdateDetail(this.updatedDetail);
}


class SubmitDetails extends AddPannelsEvent {}

class ClearDetails extends AddPannelsEvent {}
