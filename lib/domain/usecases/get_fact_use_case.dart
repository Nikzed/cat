import 'package:cats/core/usecase/usecase.dart';
import 'package:cats/domain/entities/fact_entity.dart';
import 'package:cats/domain/repositories/cats_repository.dart';

class GetFactUseCase extends UseCase<FactEntity, void> {
  final CatsRepository repository;

  GetFactUseCase(this.repository);

  @override
  Future<FactEntity> call({void params}) {
    return repository.getFact();
  }
}
