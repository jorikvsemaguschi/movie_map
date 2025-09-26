import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cinema.dart';
import '../bloc/map_bloc.dart';
import '../bloc/map_event.dart';

class CinemaTile extends StatelessWidget {
  final Cinema cinema;

  const CinemaTile({super.key, required this.cinema});

  @override
  Widget build(BuildContext context) {
    final selectedCinema = context.select<MapBloc, Cinema?>(
      (bloc) => bloc.state.selectedCinema,
    );
    final isSelected = selectedCinema?.id == cinema.id;

    return GestureDetector(
      onTap: () {
        context.read<MapBloc>().add(CinemaSelected(cinema));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.blueAccent,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cinema.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isSelected ? Colors.blue : Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            if (cinema.distance != null)
              Text(
                "${cinema.distance!.toStringAsFixed(1)} км",
                style: const TextStyle(color: Colors.black54),
              ),
          ],
        ),
      ),
    );
  }
}
