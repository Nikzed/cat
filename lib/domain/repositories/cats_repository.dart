import 'package:cats/domain/entities/fact_entity.dart';

abstract class CatsRepository {
  Future<FactEntity> getFact();
}
