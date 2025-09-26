import 'package:equatable/equatable.dart';
import 'package:movie_map/domain/entities/cinema.dart';

class MapState extends Equatable {
  final List<Cinema> cinemas;
  final Cinema? selectedCinema;
  final bool isLoading;

  const MapState({
    this.cinemas = const [],
    this.selectedCinema,
    this.isLoading = false,
  });

  MapState copyWith({
    List<Cinema>? cinemas,
    Cinema? selectedCinema,
    bool? isLoading,
  }) {
    return MapState(
      cinemas: cinemas ?? this.cinemas,
      selectedCinema: selectedCinema ?? this.selectedCinema,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [cinemas, selectedCinema, isLoading];
}
