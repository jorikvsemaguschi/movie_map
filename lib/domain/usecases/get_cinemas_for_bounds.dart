import '../entities/cinema.dart';
import '../repositories/cinema_repository.dart';

class GetCinemasForBoundsUseCase {
  final CinemaRepository repository;

  GetCinemasForBoundsUseCase(this.repository);

  Future<List<Cinema>> call(
      double northEastLat,
      double northEastLng,
      double southWestLat,
      double southWestLng,
      ) {
    return repository.getCinemasForBounds(
      northEastLat,
      northEastLng,
      southWestLat,
      southWestLng,
    );
  }
}
