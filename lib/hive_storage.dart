import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_storage_store.dart';

HiveStorage get getHiveStorage => GetIt.I.get<HiveStorage>();

class HiveStorageImp extends HiveStorage {
  static Future<void> hiveInjector(
      {List<String> storageBox = const <String>[]}) async {
    List<String> boxNames = <String>[];
    boxNames.add(HiveStorage.userBox);
    if (storageBox.isNotEmpty) boxNames.addAll(storageBox);
    GetIt.I.registerSingletonAsync<HiveStorage>(
      () async {
        await Hive.initFlutter();
        for (var boxName in boxNames) {
          await Hive.openBox<dynamic>(boxName);
        }
        return HiveStorageImp();
      },
    );
    await GetIt.I.allReady();
  }

  @override
  FutureOr<void> write({
    required String key,
    required dynamic value,
    String boxName = HiveStorage.userBox,
  }) async {
    var box = Hive.box<dynamic>(boxName);
    await box.put(key, value);
    printLog('boxName($boxName), write($key, $value)');
  }

  @override
  T? read<T>({
    required String key,
    T? defaultValue,
    String boxName = HiveStorage.userBox,
  }) {
    var box = Hive.box<dynamic>(boxName);
    final value = box.get(key, defaultValue: defaultValue) as T?;
    printLog('read($key), boxName($boxName), value: $value');

    return value;
  }

  @override
  List readBox<T>({String boxName = HiveStorage.userBox,}) {
    var box = Hive.box<dynamic>(boxName);
    final value = (box.values).toList();
    printLog('readBox($boxName), value: $value');
    return value;
  }

  @override
  void printLog(dynamic msg) {
    if (kDebugMode) {
      print('::HiveStorage:: \x1B[32m() => ${msg.toString()}\x1B[0m');
    }
  }

  @override
  Future<void> clearStorage<T>({
    List<String> boxNames = const <String>[],
  }) async {
    await Hive.box<dynamic>(HiveStorage.userBox).clear();
    printLog('clearStorage(${HiveStorage.userBox})');
    for (var boxName in boxNames) {
      if (await Hive.boxExists(boxName)) {
        await Hive.box<dynamic>(boxName).clear();
        printLog('clearStorage($boxName})');
      }
    }
  }
}
