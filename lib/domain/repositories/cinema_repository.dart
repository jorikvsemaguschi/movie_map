import '../entities/cinema.dart';

abstract class CinemaRepository {
  Future<List<Cinema>> getCinemasForBounds(
      double northEastLat,
      double northEastLng,
      double southWestLat,
      double southWestLng,
      );
}
