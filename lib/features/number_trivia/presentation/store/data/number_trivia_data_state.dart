import 'package:equatable/equatable.dart';

import '../../../domain/entities/number_trivia.dart';

sealed class NumberTriviaDataState extends Equatable {
  const NumberTriviaDataState();

  @override
  List<Object> get props => [];
}

final class Empty extends NumberTriviaDataState {
  const Empty();
}

final class Loading extends NumberTriviaDataState {}

final class Loaded extends NumberTriviaDataState {
  final NumberTrivia numberTrivia;

  const Loaded({required this.numberTrivia});
}

final class Error extends NumberTriviaDataState {
  final String message;

  const Error({required this.message});
}
