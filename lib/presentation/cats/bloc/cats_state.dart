part of 'cats_bloc.dart';

@immutable
abstract class CatsState {}

class CatsInitial extends CatsState {}

class CatsLoadingState extends CatsState {}

class CatsLoadedState extends CatsState {
  final FactEntity factEntity;

  CatsLoadedState(this.factEntity);
}

class CatsErrorState {
  Exception error;

  CatsErrorState(this.error);
}