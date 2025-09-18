class Cinema {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double? distance;

  Cinema({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.distance,
  });

  
  Cinema copyWith({double? distance}) {
    return Cinema(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      distance: distance ?? this.distance,
    );
  }
}
