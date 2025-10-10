import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_map/domain/entities/cinema.dart';

part 'cinema_model.freezed.dart';
part 'cinema_model.g.dart';

// Model for cinema data from API
@freezed
class CinemaModel with _$CinemaModel {
  const factory CinemaModel({
    @JsonKey(name: "place_id") required String id,
    required String name,
    required Geometry geometry,
  }) = _CinemaModel;

  factory CinemaModel.fromJson(Map<String, dynamic> json) =>
      _$CinemaModelFromJson(json);
}

// Geometry model for location
@freezed
class Geometry with _$Geometry {
  const factory Geometry({
    required Location location,
  }) = _Geometry;

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}

// Location coordinates
@freezed
class Location with _$Location {
  const factory Location({
    required double lat,
    required double lng,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

// Convert CinemaModel to domain entity
extension CinemaModelX on CinemaModel {
  Cinema toEntity() => Cinema(
    id: id,
    name: name,
    latitude: geometry.location.lat,
    longitude: geometry.location.lng,
  );
}


