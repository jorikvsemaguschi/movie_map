import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_map/domain/entities/cinema.dart';

part 'cinema_model.freezed.dart';
part 'cinema_model.g.dart';

@freezed
class CinemaModel with _$CinemaModel {
  const factory CinemaModel({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
    double? distance,
  }) = _CinemaModel;

  factory CinemaModel.fromJson(Map<String, dynamic> json) =>
      _$CinemaModelFromJson(json);
}

extension CinemaModelX on CinemaModel {
  Cinema toEntity() => Cinema(
    id: id,
    name: name,
    latitude: latitude,
    longitude: longitude,
    distance: distance,
  );
}

