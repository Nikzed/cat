import 'package:hive/hive.dart';

part 'fact_hive_model.g.dart';

@HiveType(typeId: 0)
class FactHiveModel {
  @HiveField(0)
  String text;

  @HiveField(1)
  DateTime createdDate;

  FactHiveModel(this.text, this.createdDate);
}
