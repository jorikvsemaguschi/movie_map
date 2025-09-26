import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:lottie/lottie.dart';

import '../bloc/map_bloc.dart';
import '../bloc/map_event.dart';
import '../bloc/map_state.dart';
import '../widgets/tiles_section.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  gmap.GoogleMapController? _mapController;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Movie Map")),
          body: Stack(
            children: [
              gmap.GoogleMap(
                initialCameraPosition: const gmap.CameraPosition(
                  target: gmap.LatLng(53.9, 27.5667), // Минск
                  zoom: 12,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onCameraIdle: () async {
                  if (_mapController != null) {
                    final bounds = await _mapController!.getVisibleRegion();
                    context.read<MapBloc>().add(
                      MapMoved(
                        north: bounds.northeast.latitude,
                        south: bounds.southwest.latitude,
                        east: bounds.northeast.longitude,
                        west: bounds.southwest.longitude,
                      ),
                    );
                  }
                },
                markers: state.cinemas
                    .map(
                      (cinema) => gmap.Marker(
                    markerId: gmap.MarkerId(cinema.id),
                    position: gmap.LatLng(cinema.latitude, cinema.longitude),
                    infoWindow: gmap.InfoWindow(title: cinema.name),
                    onTap: () {
                      context.read<MapBloc>().add(CinemaSelected(cinema));
                    },
                  ),
                )
                    .toSet(),
              ),

              // Animation of the marker on top of the map
              if (state.selectedCinema != null)
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 32,
                  top: MediaQuery.of(context).size.height / 2 - 80,
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: Lottie.asset(
                      'assets/lottie/mark_animation.json',
                      repeat: false,
                    ),
                  ),
                ),

              const Align(
                alignment: Alignment.bottomCenter,
                child: TilesSection(),
              ),
            ],
          ),
        );
      },
    );
  }
}
