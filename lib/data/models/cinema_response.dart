import 'package:freezed_annotation/freezed_annotation.dart';
import 'cinema_model.dart';

part 'cinema_response.freezed.dart';
part 'cinema_response.g.dart';

@freezed
class CinemaResponse with _$CinemaResponse {
  const factory CinemaResponse({
    required List<CinemaModel> results,
  }) = _CinemaResponse;

  factory CinemaResponse.fromJson(Map<String, dynamic> json) =>
      _$CinemaResponseFromJson(json);
}
