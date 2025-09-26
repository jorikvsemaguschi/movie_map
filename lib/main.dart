import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'presentation/bloc/map_bloc.dart';
import 'presentation/screens/map_screen.dart';

import 'data/datasources/remote_cinema_data_source.dart';
import 'data/repositories/cinema_repository_impl.dart';
import 'domain/usecases/get_cinemas_for_bounds.dart';
import 'domain/usecases/sort_cinemas_by_distance.dart';

void main() {
  final dio = Dio();
  const apiKey = "AIzaSyDdyo9wzS2lWh_T1rno00KvSqgljApN1zs";

  final remoteDataSource = RemoteCinemaDataSource(dio);
  final repository = CinemaRepositoryImpl(remoteDataSource, apiKey);

  final getCinemasForBounds = GetCinemasForBoundsUseCase(repository);
  final sortCinemasByDistance = SortCinemasByDistanceUseCase();

  runApp(MovieMapApp(
    getCinemasForBounds: getCinemasForBounds,
    sortCinemasByDistance: sortCinemasByDistance,
  ));
}

class MovieMapApp extends StatelessWidget {
  final GetCinemasForBoundsUseCase getCinemasForBounds;
  final SortCinemasByDistanceUseCase sortCinemasByDistance;

  const MovieMapApp({
    super.key,
    required this.getCinemasForBounds,
    required this.sortCinemasByDistance,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => MapBloc(
          getCinemasForBounds: getCinemasForBounds,
          sortCinemasByDistance: sortCinemasByDistance,
        ),
        child: const MapScreen(),
      ),
    );
  }
}

