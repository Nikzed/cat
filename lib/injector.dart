import 'dart:io';

import 'package:cats/data/exceptions/base_error_handler.dart';
import 'package:cats/data/mappers/fact_entity_mapper.dart';
import 'package:cats/data/repositories/cats_repository_impl.dart';
import 'package:cats/data/services/cats_service.dart';
import 'package:cats/domain/repositories/cats_repository.dart';
import 'package:cats/domain/usecases/add_saved_fact.dart';
import 'package:cats/domain/usecases/get_fact_use_case.dart';
import 'package:cats/presentation/cats/bloc/cats_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

setup() async {
  // Error handlers
  injector.registerLazySingleton<BaseErrorHandler>(() => BaseErrorHandler());

  // Dio
  injector.registerSingleton(
    Dio(
      BaseOptions(
        contentType: ContentType.json.toString(),
        sendTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  // Services
  injector.registerLazySingleton(() => CatsService(injector()));

  // Mappers
  injector.registerFactory(() => FactEntityMapper());

  // Repositories
  injector.registerLazySingleton<CatsRepository>(() => CatsRepositoryImpl(injector(), injector(), injector()));

  // Use cases
  injector.registerLazySingleton(() => GetFactUseCase(injector()));
  injector.registerLazySingleton(() => SetSavedFacts());

  // BloC
  injector.registerFactory(() => CatsBloc(injector(), injector()));
}
