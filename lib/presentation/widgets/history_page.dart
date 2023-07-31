import 'package:cats/data/storage/fact_hive_model.dart';
import 'package:cats/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: factBox.length,
        itemBuilder: (context, index) {
          FactHiveModel fact = factBox.getAt(index);
          return _tileElement(fact);
        },
      ),
    );
  }

  Widget _tileElement(FactHiveModel fact) {
    return ListTile(
      title: Text('${DateFormat.yMMMMd().format(fact.createdDate)}. ${DateFormat.Hms().format(fact.createdDate)}'),
      subtitle: Text(fact.text),
    );
  }
}
