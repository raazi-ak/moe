
class PannelModel{
  late String system_id;
  late String name;
  late DeviceLocation? location;
  late double? azimuth;
  late double? tilt;
  late String? capacity;
  late int? bat_no;
  late int? pan_no;

  PannelModel({
    required this.system_id,
    required this.name,
    this.location,
    this.azimuth,
    this.tilt,
    this.capacity,
    this.bat_no,
    this.pan_no,
  });
}

class DeviceLocation {
  double lat;
  double long;
  DeviceLocation({required this.lat, required this.long});
}