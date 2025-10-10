import 'dart:math';
import '../entities/cinema.dart';

// Use case for sorting cinemas by distance from selected
class SortCinemasByDistanceUseCase {
  List<Cinema> call(Cinema selected, List<Cinema> all) {
    double distance(Cinema a, Cinema b) {
      const R = 6371;
      double dLat = (b.latitude - a.latitude) * pi / 180;
      double dLon = (b.longitude - a.longitude) * pi / 180;
      double lat1 = a.latitude * pi / 180;
      double lat2 = b.latitude * pi / 180;

      double h = sin(dLat / 2) * sin(dLat / 2) +
          sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
      return 2 * R * atan2(sqrt(h), sqrt(1 - h));
    }

    List<Cinema> sorted = all.map((c) {
      return c.copyWith(distance: distance(selected, c));
    }).toList();

    sorted.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
    return sorted;
  }
}
