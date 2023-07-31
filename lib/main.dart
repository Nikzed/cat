import 'package:cats/data/storage/fact_hive_model.dart';
import 'package:cats/presentation/cats/cats_home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'injector.dart';
import 'package:intl/date_symbol_data_local.dart';

late Box factBox;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FactHiveModelAdapter());
  factBox = await Hive.openBox<FactHiveModel>('Facts');

  await setup();
  initializeDateFormatting();

  runApp(const CatsApp());
}

class CatsApp extends StatelessWidget {
  const CatsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CatsHome(),
    );
  }
}
