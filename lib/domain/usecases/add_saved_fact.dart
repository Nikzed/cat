import 'package:cats/core/usecase/usecase.dart';
import 'package:cats/data/storage/fact_hive_model.dart';
import 'package:cats/domain/entities/fact_entity.dart';
import 'package:cats/main.dart';

class SetSavedFacts implements UseCase<void, FactEntity> {
  @override
  Future<void> call({required FactEntity params}) async {
    factBox.put('key${params.time}', FactHiveModel(params.text, params.time));
  }
}
