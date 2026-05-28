import 'package:bloc/bloc.dart';

import 'models/bloc_event_record.dart';
import 'store/bloc_visualizer_store.dart';

/// Captures Bloc events and forwards them to a [BlocVisualizerStore].
class BlocVisualizerObserver extends BlocObserver {
  BlocVisualizerObserver({BlocVisualizerStore? store, DateTime Function()? now})
    : _store = store ?? BlocVisualizerStore.instance,
      _now = now ?? DateTime.now;

  final BlocVisualizerStore _store;
  final DateTime Function() _now;

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);

    _store.addEvent(
      BlocEventRecord(
        id: _store.nextEventId(),
        blocName: bloc.runtimeType.toString(),
        eventName: event.runtimeType.toString(),
        eventValue: event.toString(),
        timestamp: _now(),
      ),
    );
  }
}
