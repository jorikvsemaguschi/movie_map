import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_map/domain/entities/cinema.dart';
import 'package:movie_map/domain/usecases/get_cinemas_for_bounds.dart';
import 'package:movie_map/domain/usecases/sort_cinemas_by_distance.dart';
import 'map_event.dart';
import 'map_state.dart';

// Bloc for map logic and state
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetCinemasForBoundsUseCase getCinemasForBounds;
  final SortCinemasByDistanceUseCase sortCinemasByDistance;

  MapBloc({
    required this.getCinemasForBounds,
    required this.sortCinemasByDistance,
  }) : super(const MapState()) {
    on<MapMoved>(_onMapMoved);
    on<CinemaSelected>(_onCinemaSelected);
    on<CinemaDeselected>(_onCinemaDeselected);
  }

  // Handle map movement
  Future<void> _onMapMoved(MapMoved event, Emitter<MapState> emit) async {
    emit(state.copyWith(isLoading: true));

    final cinemas = await getCinemasForBounds(
      event.north,
      event.south,
      event.east,
      event.west,
    );

    if (state.fixedCenterCinema != null) {
      final sorted = sortCinemasByDistance(state.fixedCenterCinema!, cinemas);
      emit(state.copyWith(cinemas: sorted, isLoading: false));
    } else {
      emit(state.copyWith(cinemas: cinemas, isLoading: false));
    }
  }

  // Handle cinema selection
  Future<void> _onCinemaSelected(
      CinemaSelected event, Emitter<MapState> emit) async {
    final sorted = sortCinemasByDistance(event.cinema, state.cinemas);
    emit(state.copyWith(
      cinemas: sorted,
      selectedCinema: event.cinema,
      fixedCenterCinema: event.cinema,
      selectedCinemaSet: true,
      fixedCenterCinemaSet: true,
    ));
  }

  // Handle cinema deselection
  void _onCinemaDeselected(
      CinemaDeselected event, Emitter<MapState> emit) {
    emit(state.copyWith(
      selectedCinema: null,
      fixedCenterCinema: null,
      selectedCinemaSet: true,
      fixedCenterCinemaSet: true,
    ));
  }
}




