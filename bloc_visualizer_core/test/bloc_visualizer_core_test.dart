import 'package:bloc/bloc.dart';
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

  test('store keeps the latest events up to max events', () {
    final store = BlocVisualizerStore(maxEvents: 2);

    store
      ..addEvent(_eventRecord(id: 'event-1'))
      ..addEvent(_eventRecord(id: 'event-2'))
      ..addEvent(_eventRecord(id: 'event-3'));

    expect(store.snapshot.events.map((event) => event.id), [
      'event-2',
      'event-3',
    ]);
  });

  test('store ignores events while paused', () {
    final store = BlocVisualizerStore(maxEvents: 2)..pause();

    store.addEvent(_eventRecord(id: 'event-1'));

    expect(store.snapshot.events, isEmpty);
    expect(store.snapshot.isPaused, isTrue);
  });

  test('observer captures bloc events into the store', () async {
    final store = BlocVisualizerStore();
    final bloc = _CounterBloc();
    final observer = BlocVisualizerObserver(
      store: store,
      now: () => DateTime(2026, 5, 27, 12, 30),
    );

    observer.onEvent(bloc, const _CounterIncrementPressed(1));

    final event = store.snapshot.events.single;
    expect(event.id, 'event-1');
    expect(event.blocName, '_CounterBloc');
    expect(event.eventName, '_CounterIncrementPressed');
    expect(event.eventValue, '_CounterIncrementPressed(amount: 1)');
    expect(event.timestamp, DateTime(2026, 5, 27, 12, 30));

    await bloc.close();
  });
}

BlocEventRecord _eventRecord({required String id}) {
  return BlocEventRecord(
    id: id,
    blocName: 'CounterBloc',
    eventName: 'CounterIncrementPressed',
    eventValue: 'CounterIncrementPressed(amount: 1)',
    timestamp: DateTime(2026, 5, 27, 12, 30),
  );
}

final class _CounterBloc extends Bloc<_CounterEvent, int> {
  _CounterBloc() : super(0);
}

sealed class _CounterEvent {
  const _CounterEvent();
}

final class _CounterIncrementPressed extends _CounterEvent {
  const _CounterIncrementPressed(this.amount);

  final int amount;

  @override
  String toString() => '_CounterIncrementPressed(amount: $amount)';
}
