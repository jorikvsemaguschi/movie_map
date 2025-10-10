import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:lottie/lottie.dart';
import 'package:movie_map/domain/entities/cinema.dart';
import 'package:movie_map/presentation/bloc/map_bloc.dart';
import 'package:movie_map/presentation/bloc/map_event.dart';
import 'package:movie_map/presentation/bloc/map_state.dart';
import 'package:movie_map/presentation/widgets/tiles_section.dart';
import 'package:movie_map/presentation/widgets/map_controller_provider.dart';

// Main map screen widget
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  gmap.GoogleMapController? _mapController;
  Offset? _markerScreenPos;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  // Update marker position for selected cinema
  Future<void> _updateMarkerPosition(Cinema? cinema) async {
    if (cinema == null || _mapController == null) {
      setState(() => _markerScreenPos = null);
      return;
    }

    await Future.delayed(const Duration(milliseconds: 150));

    try {
      final screen = await _mapController!.getScreenCoordinate(
        gmap.LatLng(cinema.latitude, cinema.longitude),
      );
      setState(() {
        _markerScreenPos = Offset(screen.x.toDouble(), screen.y.toDouble());
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) async {
        if (state.selectedCinema != null) {
          await _updateMarkerPosition(state.selectedCinema);
        } else {
          setState(() => _markerScreenPos = null);
        }
      },
      builder: (context, state) {
        return MapControllerProvider(
          controller: _mapController,
          child: Scaffold(
            appBar: AppBar(title: const Text("Movie Map")),
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                // Google Map widget
                Positioned.fill(
                  child: gmap.GoogleMap(
                    initialCameraPosition: const gmap.CameraPosition(
                      target: gmap.LatLng(53.9, 27.5667),
                      zoom: 12,
                    ),
                    onMapCreated: (controller) => _mapController = controller,
                    onTap: (_) {
                      context.read<MapBloc>().add(const CinemaDeselected());
                    },
                    onCameraMove: (_) {
                      if (state.selectedCinema != null) {
                        _debounce?.cancel();
                        _debounce = Timer(
                          const Duration(milliseconds: 50),
                              () => _updateMarkerPosition(state.selectedCinema),
                        );
                      }
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
                        if (state.selectedCinema != null) {
                          _updateMarkerPosition(state.selectedCinema);
                        }
                      }
                    },
                    markers: state.cinemas.map((cinema) {
                      return gmap.Marker(
                        markerId: gmap.MarkerId(cinema.id),
                        position:
                        gmap.LatLng(cinema.latitude, cinema.longitude),
                        infoWindow: gmap.InfoWindow(title: cinema.name),
                        onTap: () async {
                          context.read<MapBloc>().add(CinemaSelected(cinema));
                          await Future.delayed(
                              const Duration(milliseconds: 300));
                          await _updateMarkerPosition(cinema);
                        },
                      );
                    }).toSet(),
                  ),
                ),
                // Lottie animation above selected marker
                if (_markerScreenPos != null)
                  Positioned(
                    left: _markerScreenPos!.dx - 32,
                    top: _markerScreenPos!.dy - 64,
                    child: IgnorePointer(
                      ignoring: true,
                      child: RepaintBoundary(
                        child: Lottie.asset(
                          'assets/lottie/mark_animation.json',
                          width: 64,
                          height: 64,
                          repeat: true,
                          animate: true,
                          key: ValueKey(state.selectedCinema?.id),
                        ),
                      ),
                    ),
                  ),
                // Tiles section at bottom
                if (state.selectedCinema != null)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: TilesSection(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}