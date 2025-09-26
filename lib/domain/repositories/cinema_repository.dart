import '../entities/cinema.dart';

abstract class CinemaRepository {
  Future<List<Cinema>> getCinemasForBounds(
      double north,
      double south,
      double east,
      double west,
      );
}

