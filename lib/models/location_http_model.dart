class LocationHttpModel {
  const LocationHttpModel(
      {required this.latitude,
      required this.id,
      required this.longitude,
      required this.formattedAddress});

  final int id;
  final double latitude;
  final double longitude;
  final String formattedAddress;
}
