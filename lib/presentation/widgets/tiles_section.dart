import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/map_bloc.dart';
import '../bloc/map_state.dart';
import 'cinema_tile.dart';

class TilesSection extends StatelessWidget {
  const TilesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state.cinemas.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 200,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.cinemas.length,
            itemBuilder: (context, index) {
              final cinema = state.cinemas[index];
              return CinemaTile(cinema: cinema);
            },
          ),
        );
      },
    );
  }
}
