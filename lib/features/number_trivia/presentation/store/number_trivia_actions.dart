import 'package:equatable/equatable.dart';

import '../../domain/entities/number_trivia.dart';

sealed class NumberTriviaAction extends Equatable {
  const NumberTriviaAction();

  @override
  List<Object> get props => [];
}

final class GetConcrete extends NumberTriviaAction {
  final String numberString;

  const GetConcrete(this.numberString);
}

final class GetRandom extends NumberTriviaAction {}

final class FetchSuccess extends NumberTriviaAction {
  final NumberTrivia trivia;

  const FetchSuccess(this.trivia);
}

final class FetchFailed extends NumberTriviaAction {
  final String message;

  const FetchFailed(this.message);
}
