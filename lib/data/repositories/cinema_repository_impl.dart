import 'package:movie_map/domain/entities/cinema.dart';
import 'package:movie_map/domain/repositories/cinema_repository.dart';

import '../datasources/remote_cinema_data_source.dart';

class CinemaRepositoryImpl implements CinemaRepository {
  final RemoteCinemaDataSource remoteDataSource;

  CinemaRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Cinema>> getCinemasForBounds(double north,
      double south,
      double east,
      double west,) {
    return remoteDataSource.fetchCinemasForBounds(
      north,
      south,
      east,
      west,
    );
  }
}