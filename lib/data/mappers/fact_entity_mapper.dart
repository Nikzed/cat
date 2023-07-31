import 'package:cats/core/utils/mapper.dart';
import 'package:cats/data/responses/fact_response.dart';
import 'package:cats/domain/entities/fact_entity.dart';

class FactEntityMapper extends Mapper<FactResponse, FactEntity> {
  @override
  FactEntity map(FactResponse value) {
    return FactEntity(value.text ?? '', DateTime.now());
  }
}
