import 'package:flutter/foundation.dart';

import '../models/bloc_event_record.dart';
import '../models/bloc_visualizer_snapshot.dart';

/// Keeps the current visualizer state in memory.
class BlocVisualizerStore extends ChangeNotifier {
  BlocVisualizerStore({this.maxEvents = 500});

  static final BlocVisualizerStore instance = BlocVisualizerStore();

  final int maxEvents;

  final List<BlocEventRecord> _events = [];
  var _isPaused = false;
  var _eventCount = 0;

  BlocVisualizerSnapshot get snapshot {
    return BlocVisualizerSnapshot(
      events: List.unmodifiable(_events),
      isPaused: _isPaused,
    );
  }

  String nextEventId() {
    _eventCount += 1;
    return 'event-$_eventCount';
  }

  void addEvent(BlocEventRecord event) {
    if (_isPaused) {
      return;
    }

    _events.add(event);

    if (_events.length > maxEvents) {
      _events.removeRange(0, _events.length - maxEvents);
    }

    notifyListeners();
  }

  void clear() {
    if (_events.isEmpty) {
      return;
    }

    _events.clear();
    notifyListeners();
  }

  void pause() {
    if (_isPaused) {
      return;
    }

    _isPaused = true;
    notifyListeners();
  }

  void resume() {
    if (!_isPaused) {
      return;
    }

    _isPaused = false;
    notifyListeners();
  }
}
