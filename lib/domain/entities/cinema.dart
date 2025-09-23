import 'package:freezed_annotation/freezed_annotation.dart';

part 'cinema.freezed.dart';

@freezed
class Cinema with _$Cinema {
  const factory Cinema({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
    double? distance,
  }) = _Cinema;
}

