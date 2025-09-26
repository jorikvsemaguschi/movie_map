import 'package:equatable/equatable.dart';
import 'package:movie_map/domain/entities/cinema.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

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

class CinemaSelected extends MapEvent {
  final Cinema cinema;

  const CinemaSelected(this.cinema);

  @override
  List<Object?> get props => [cinema];
}
