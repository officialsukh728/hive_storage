import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_storage/hive_storage.dart';

Future<void> main() async {
  await HiveStorageImp.hiveInjector();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String get countKey => "countKey";
  int count = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Hive Storage Example'),
          ),
          body: Center(
            child: Text('Value $count'),
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  count = count + 1;
                  await getHiveStorage.write(
                    value: count,
                    key: countKey,
                  );
                  getData();
                },
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                child: const Icon(Icons.minimize),
                onPressed: () async {
                  count = count - 1;
                  await getHiveStorage.write(
                    value: count,
                    key: countKey,
                  );
                  getData();
                },
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                child: const Icon(Icons.clear),
                onPressed:()=> clearStorage(),
              ),
            ],
          )),
    );
  }

  void getData() {
    setState(() {
      _getCount();
    });
  }

  void _getCount() {
    count = getHiveStorage.read(key: countKey) ?? 0;
  }

  void clearStorage () async{
  await getHiveStorage.clearStorage();
   getData();
  }
}
