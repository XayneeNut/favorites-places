class LocationModel {
  const LocationModel(
      {required this.latitude,
      required this.longitude,
      required this.formatedAddress});

  final double latitude;
  final double longitude;
  final String formatedAddress;
}
