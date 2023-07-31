part of 'cats_bloc.dart';

@immutable
abstract class CatsEvent {}

class CatsLoadFactEvent extends CatsEvent {}

class CatsSaveFactEvent extends CatsEvent {
  final FactEntity fact;

  CatsSaveFactEvent(this.fact);
}