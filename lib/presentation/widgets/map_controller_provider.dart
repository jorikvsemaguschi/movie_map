import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

class MapControllerProvider extends InheritedWidget {
  final gmap.GoogleMapController? controller;

  const MapControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static gmap.GoogleMapController? of(BuildContext context) {
    final provider =
    context.dependOnInheritedWidgetOfExactType<MapControllerProvider>();
    return provider?.controller;
  }

  @override
  bool updateShouldNotify(MapControllerProvider oldWidget) =>
      controller != oldWidget.controller;
}
