import 'package:movie_map/domain/entities/cinema.dart';
import 'package:movie_map/domain/repositories/cinema_repository.dart';

import '../datasources/remote_cinema_data_source.dart';
import '../models/cinema_model.dart';

// Implementation of CinemaRepository using remote data source
class CinemaRepositoryImpl implements CinemaRepository {
  final RemoteCinemaDataSource remoteDataSource;
  final String apiKey;

  CinemaRepositoryImpl(this.remoteDataSource, this.apiKey);

  @override
  Future<List<Cinema>> getCinemasForBounds(
      double north,
      double south,
      double east,
      double west,
      ) async {
    // Calculate center and radius for API request
    final centerLat = (north + south) / 2;
    final centerLng = (east + west) / 2;
    final latDiff = (north - south).abs();
    final lngDiff = (east - west).abs();
    final radius = ((latDiff + lngDiff) / 2 * 111_000 / 2).toInt();

    final response = await remoteDataSource.fetchCinemasNearby(
      "$centerLat,$centerLng",
      radius,
      "movie_theater",
      apiKey,
    );

    return response.results.map((m) => m.toEntity()).toList();
  }
}
