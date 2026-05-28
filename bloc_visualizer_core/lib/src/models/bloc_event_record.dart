/// A captured event emitted by a Bloc.
class BlocEventRecord {
  const BlocEventRecord({
    required this.id,
    required this.blocName,
    required this.eventName,
    required this.eventValue,
    required this.timestamp,
  });

  final String id;
  final String blocName;
  final String eventName;
  final String eventValue;
  final DateTime timestamp;
}
