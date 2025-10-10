import '../entities/cinema.dart';
import '../repositories/cinema_repository.dart';

// Use case for fetching cinemas within map bounds
class GetCinemasForBoundsUseCase {
  final CinemaRepository repository;

  GetCinemasForBoundsUseCase(this.repository);

  Future<List<Cinema>> call(
      double north,
      double south,
      double east,
      double west,
      ) {
    return repository.getCinemasForBounds(north, south, east, west);
  }
}

