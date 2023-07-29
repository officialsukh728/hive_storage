part of 'hive_storage.dart';

abstract class HiveStorage {
  static const String userBox = "UserBox";

  /// Insert a key/value pair.
  /// Allows for a dynamic value as various storage options (eg. Hive)
  /// are able to store more than just primitive data types.
  FutureOr<void> write({
    required String key,
    required dynamic value,
    String boxName = userBox,
  });

  /// Return the value for the given `key`.
  /// If value doesn't exist, optionally return the given
  /// `defaultValue` of `<T>`.
  T? read<T>({
    required String key,
    String boxName = userBox,
    T? defaultValue,
  });

  Future<void> clearStorage<T>({
    List<String> boxNames = const <String>[],
  });

  List readBox<T>({
    String boxName = userBox,
  });

  void printLog(dynamic msg);
}
