import 'package:flutter/material.dart';

import '../store/bloc_visualizer_store.dart';

/// Displays a compact timeline of captured Bloc events.
///
/// By default, it reads from [BlocVisualizerStore.instance].
/// Pass a custom [store] when you want isolated state for tests,
/// demos, or multiple visualizers.
/// [height] and [width] are the dimensions of the visualizer widget.
class SimpleBlocVisualizerWidget extends StatelessWidget {
  final double height;
  final double width;
  const SimpleBlocVisualizerWidget({
    super.key,
    BlocVisualizerStore? store,
    this.height = 200,
    this.width = 500,
  }) : _store = store;

  final BlocVisualizerStore? _store;

  BlocVisualizerStore get store => _store ?? BlocVisualizerStore.instance;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, child) => SizedBox(
        height: height,
        width: width,
        child: Card(
          child: Column(
            children: [
              Text('Bloc Visualizer'),
              Text('Events: ${store.snapshot.events.length}'),
              Text('Paused: ${store.snapshot.isPaused}'),
            ],
          ),
        ),
      ),
    );
  }
}
