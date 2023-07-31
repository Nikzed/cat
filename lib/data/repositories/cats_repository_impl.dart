import 'dart:async';

import 'package:cats/data/exceptions/base_error_handler.dart';
import 'package:cats/data/mappers/fact_entity_mapper.dart';
import 'package:cats/data/services/cats_service.dart';
import 'package:cats/domain/entities/fact_entity.dart';
import 'package:cats/domain/repositories/cats_repository.dart';

class CatsRepositoryImpl extends CatsRepository {
  final CatsService _service;
  final FactEntityMapper _mapper;
  final BaseErrorHandler _baseErrorHandler;

  CatsRepositoryImpl(this._service, this._mapper, this._baseErrorHandler);

  @override
  Future<FactEntity> getFact() {
    return _service
        .getFact()
        .then((value) => _mapper.map(value))
        .onError((error, stackTrace) => _baseErrorHandler.handleError(error));
  }
}

