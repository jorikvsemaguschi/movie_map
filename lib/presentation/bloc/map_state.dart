import 'package:equatable/equatable.dart';
import 'package:movie_map/domain/entities/cinema.dart';

// State for map screen
class MapState extends Equatable {
  final List<Cinema> cinemas;
  final Cinema? selectedCinema;
  final Cinema? fixedCenterCinema;
  final bool isLoading;

  const MapState({
    this.cinemas = const [],
    this.selectedCinema,
    this.fixedCenterCinema,
    this.isLoading = false,
  });

  // Copy state with optional overrides
  MapState copyWith({
    List<Cinema>? cinemas,
    Cinema? selectedCinema,
    Cinema? fixedCenterCinema,
    bool selectedCinemaSet = false,
    bool fixedCenterCinemaSet = false,
    bool? isLoading,
  }) {
    return MapState(
      cinemas: cinemas ?? this.cinemas,
      selectedCinema: selectedCinemaSet ? selectedCinema : this.selectedCinema,
      fixedCenterCinema:
      fixedCenterCinemaSet ? fixedCenterCinema : this.fixedCenterCinema,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props =>
      [cinemas, selectedCinema, fixedCenterCinema, isLoading];
}


