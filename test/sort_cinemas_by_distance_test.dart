import 'package:flutter_test/flutter_test.dart';
import 'package:movie_map/domain/entities/cinema.dart';
import 'package:movie_map/domain/usecases/sort_cinemas_by_distance.dart';

void main() {
  group('SortCinemasByDistanceUseCase', () {
    final useCase = SortCinemasByDistanceUseCase();

    test('должен сортировать кинотеатры по расстоянию от выбранного', () {
      // Arrange
      final selected = Cinema(
        id: '1',
        name: 'Cinema A',
        latitude: 52.0,
        longitude: 27.0,
      );

      final other1 = Cinema(
        id: '2',
        name: 'Cinema B',
        latitude: 52.1,
        longitude: 27.0,
      );

      final other2 = Cinema(
        id: '3',
        name: 'Cinema C',
        latitude: 53.0,
        longitude: 27.0,
      );

      final all = [selected, other1, other2];

      // Act
      final sorted = useCase(selected, all);

      // Assert
      expect(sorted.first.id, equals('1')); // выбранный всегда первый
      expect(sorted[1].id, equals('2'));    // ближе
      expect(sorted[2].id, equals('3'));    // дальше
    });
  });
}
