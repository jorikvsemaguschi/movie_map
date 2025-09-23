import 'package:movie_map/domain/entities/cinema.dart';
import 'package:movie_map/domain/repositories/cinema_repository.dart';

import '../datasources/remote_cinema_data_source.dart';
import '../models/cinema_model.dart';

class CinemaRepositoryImpl implements CinemaRepository {
  final RemoteCinemaDataSource remoteDataSource;

  CinemaRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Cinema>> getCinemasForBounds(
      double north,
      double south,
      double east,
      double west,
      ) async {
    final models = await remoteDataSource.fetchCinemasForBounds(
      north,
      south,
      east,
      west,
    );

    return models.map((m) => m.toEntity()).toList();
  }
}
