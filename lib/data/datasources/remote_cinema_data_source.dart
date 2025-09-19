import 'package:movie_map/domain/entities/cinema.dart';

class RemoteCinemaDataSource {
  Future<List<Cinema>> fetchCinemasForBounds(double north,
      double south,
      double east,
      double west,) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      Cinema(
          id: '1', name: 'Silver Screen', latitude: 53.9, longitude: 27.5667),
      Cinema(id: '2', name: 'Dom Kino', latitude: 53.91, longitude: 27.55),
      Cinema(id: '3', name: 'Velcom Cinema', latitude: 53.92, longitude: 27.58),
    ];
  }
}