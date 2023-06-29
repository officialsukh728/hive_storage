import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_storage_store.dart';

HiveStorage get getHiveStorage => GetIt.I.get<HiveStorage>();

class HiveStorageImp extends HiveStorage {
  static Future<void> hiveInjector({required List<String> boxNames}) async {
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
  Future<void> write({
    required String boxName,
    required String key,
    required dynamic value,
  }) async {
    var box = Hive.box<dynamic>(boxName);
    await box.put(key, value);
    printLog('boxName($boxName), write($key, $value)');
  }

  @override
  T? read<T>({
    required String boxName,
    required String key,
    T? defaultValue,
  }) {
    var box = Hive.box<dynamic>(boxName);
    final value = box.get(key, defaultValue: defaultValue) as T?;
    printLog('read($key), boxName($boxName), value: $value');

    return value;
  }

  @override
  List readBox<T>(String boxName) {
    var box = Hive.box<dynamic>(boxName);
    final value = (box.values).toList();
    printLog('boxName($boxName), value: $value');

    return value;
  }

  @override
  void printLog(dynamic msg) {
    if (kDebugMode) {
      debugPrint('::HiveStorage:: \x1B[32m() => ${msg.toString()}\x1B[0m');
    }
  }
}
