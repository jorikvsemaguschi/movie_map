import '../entities/cinema.dart';

// Repository interface for fetching cinemas
abstract class CinemaRepository {
  Future<List<Cinema>> getCinemasForBounds(
      double north,
      double south,
      double east,
      double west,
      );
}

