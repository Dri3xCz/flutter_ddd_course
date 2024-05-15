import 'package:equatable/equatable.dart';

import '../../../domain/entities/number_trivia.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

final class Empty extends NumberTriviaState {
  const Empty();
}

final class Loading extends NumberTriviaState {}

final class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  const Loaded({required this.numberTrivia});
}

final class Error extends NumberTriviaState {
  final String message;

  const Error({required this.message});
}
