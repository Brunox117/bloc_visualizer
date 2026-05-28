import 'bloc_event_record.dart';

/// The current in-memory state exposed by the visualizer.
class BlocVisualizerSnapshot {
  const BlocVisualizerSnapshot({required this.events, this.isPaused = false});

  final List<BlocEventRecord> events;
  final bool isPaused;
}
