import 'dart:async';

import 'package:cats/domain/entities/fact_entity.dart';
import 'package:cats/domain/usecases/add_saved_fact.dart';
import 'package:cats/domain/usecases/get_fact_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cats_event.dart';

part 'cats_state.dart';

class CatsBloc extends Bloc<CatsEvent, CatsState> {
  final GetFactUseCase _getFactUseCase;
  final SetSavedFacts _setSavedFacts;

  CatsBloc(this._getFactUseCase, this._setSavedFacts) : super(CatsInitial()) {
    on<CatsEvent>((event, emit) {});
    on<CatsLoadFactEvent>((event, emit) => _load(event, emit));
    on<CatsSaveFactEvent>((event, emit) => _saveFact(event, emit));
  }

  Future<void> _load(CatsLoadFactEvent event, Emitter emit) async {
    emit(CatsLoadingState());
    try {
      FactEntity fact = await _getFactUseCase.call();
      emit(CatsLoadedState(fact));
      add(CatsSaveFactEvent(fact));
    } on Exception catch (e) {
      emit(CatsErrorState(e));
    }
  }

  _saveFact(CatsSaveFactEvent event, Emitter emit) async {
    try {
      await _setSavedFacts.call(params: event.fact);
    } on Exception catch (e) {
      emit(CatsErrorState(e));
    }
  }
}
