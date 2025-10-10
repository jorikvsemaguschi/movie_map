import 'package:equatable/equatable.dart';
import 'package:movie_map/domain/entities/cinema.dart';

// Base event for map
abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

// Event for map movement
class MapMoved extends MapEvent {
  final double north;
  final double south;
  final double east;
  final double west;

  const MapMoved({
    required this.north,
    required this.south,
    required this.east,
    required this.west,
  });

  @override
  List<Object?> get props => [north, south, east, west];
}

// Event for cinema selection
class CinemaSelected extends MapEvent {
  final Cinema cinema;

  const CinemaSelected(this.cinema);

  @override
  List<Object?> get props => [cinema];
}

// Event for cinema deselection
class CinemaDeselected extends MapEvent {
  const CinemaDeselected();
}

