part of 'hive_storage.dart';

abstract class HiveStorage {
  /// Insert a key/value pair.
  /// Allows for a dynamic value as various storage options (eg. Hive)
  /// are able to store more than just primitive data types.
  FutureOr<void> write({
    required String boxName,
    required String key,
    required dynamic value,
  });

  /// Return the value for the given `key`.
  /// If value doesn't exist, optionally return the given
  /// `defaultValue` of `<T>`.
  FutureOr<T?> read<T>({
    required String boxName,
    required String key,
    T? defaultValue,
  });

  List readBox<T>(String boxName);

  void printLog(dynamic msg);
}
