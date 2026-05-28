import 'package:bloc_visualizer_core/bloc_visualizer_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('creates a bloc event record', () {
    final timestamp = DateTime(2026, 5, 27, 12, 30);

    final record = BlocEventRecord(
      id: 'event-1',
      blocName: 'CounterBloc',
      eventName: 'CounterIncrementPressed',
      eventValue: 'CounterIncrementPressed(amount: 1)',
      timestamp: timestamp,
    );

    expect(record.id, 'event-1');
    expect(record.blocName, 'CounterBloc');
    expect(record.eventName, 'CounterIncrementPressed');
    expect(record.eventValue, 'CounterIncrementPressed(amount: 1)');
    expect(record.timestamp, timestamp);
  });

  test('creates a visualizer snapshot with events and paused state', () {
    final event = BlocEventRecord(
      id: 'event-1',
      blocName: 'CounterBloc',
      eventName: 'CounterIncrementPressed',
      eventValue: 'CounterIncrementPressed(amount: 1)',
      timestamp: DateTime(2026, 5, 27, 12, 30),
    );

    final snapshot = BlocVisualizerSnapshot(events: [event], isPaused: true);

    expect(snapshot.events, [event]);
    expect(snapshot.isPaused, isTrue);
  });

  test('snapshot is not paused by default', () {
    const snapshot = BlocVisualizerSnapshot(events: []);

    expect(snapshot.events, isEmpty);
    expect(snapshot.isPaused, isFalse);
  });
}
