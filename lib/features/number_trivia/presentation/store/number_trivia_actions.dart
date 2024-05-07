
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:equatable/equatable.dart';

sealed class NumberTriviaAction extends Equatable {
  const NumberTriviaAction();

  @override
  List<Object> get props => [];
}

final class GetConcrete extends NumberTriviaAction {
  final String numberString;

  GetConcrete(this.numberString);
}

final class GetRandom extends NumberTriviaAction {}

final class FetchSuccess extends NumberTriviaAction {
  final NumberTrivia trivia;

  FetchSuccess(this.trivia);
}

final class FetchFailed extends NumberTriviaAction {
  final String message;

  FetchFailed(this.message);
}