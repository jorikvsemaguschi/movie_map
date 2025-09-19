import 'package:movie_map/domain/entities/cinema.dart';

class CinemaModel extends Cinema {
  CinemaModel({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
  }) : super(
    id: id,
    name: name,
    latitude: latitude,
    longitude: longitude,
  );

  factory CinemaModel.fromJson(Map<String, dynamic> json) {
    return CinemaModel(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
