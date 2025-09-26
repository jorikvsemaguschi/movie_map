import 'package:flutter_bloc/flutter_bloc.dart';
import 'map_event.dart';
import 'map_state.dart';
import 'package:movie_map/domain/usecases/get_cinemas_for_bounds.dart';
import 'package:movie_map/domain/usecases/sort_cinemas_by_distance.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetCinemasForBoundsUseCase getCinemasForBounds;
  final SortCinemasByDistanceUseCase sortCinemasByDistance;

  MapBloc({
    required this.getCinemasForBounds,
    required this.sortCinemasByDistance,
  }) : super(const MapState()) {
    on<MapMoved>(_onMapMoved);
    on<CinemaSelected>(_onCinemaSelected);
  }

  Future<void> _onMapMoved(MapMoved event, Emitter<MapState> emit) async {
    emit(state.copyWith(isLoading: true));

    final cinemas = await getCinemasForBounds(
      event.north,
      event.south,
      event.east,
      event.west,
    );

    // Sort by distance from the first one (if any)
    if (cinemas.isNotEmpty) {
      final sorted = sortCinemasByDistance(cinemas.first, cinemas);
      emit(state.copyWith(
        cinemas: sorted,
        selectedCinema: cinemas.first,
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(cinemas: [], isLoading: false));
    }
  }

  void _onCinemaSelected(CinemaSelected event, Emitter<MapState> emit) {
    final sorted = sortCinemasByDistance(event.cinema, state.cinemas);
    emit(state.copyWith(
      selectedCinema: event.cinema,
      cinemas: sorted,
    ));
  }
}
