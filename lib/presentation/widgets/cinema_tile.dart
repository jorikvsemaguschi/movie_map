import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cinema.dart';
import '../bloc/map_bloc.dart';
import '../bloc/map_event.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:movie_map/presentation/widgets/map_controller_provider.dart';

// Widget for displaying a cinema tile
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
      onTap: () async {
        context.read<MapBloc>().add(CinemaSelected(cinema));

        final mapController = MapControllerProvider.of(context);
        if (mapController != null) {
          await mapController.animateCamera(
            gmap.CameraUpdate.newCameraPosition(
              gmap.CameraPosition(
                target: gmap.LatLng(cinema.latitude, cinema.longitude),
                zoom: 15.5,
              ),
            ),
          );
        }
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cinema name
            Text(
              cinema.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: isSelected ? Colors.blue : Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            // Distance to cinema
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

