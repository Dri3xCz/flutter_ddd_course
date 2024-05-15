import 'package:redux/redux.dart';

import 'number_trivia_actions.dart';
import 'number_trivia_state.dart';

final numberTriviaReducer = combineReducers<NumberTriviaState>([
  TypedReducer<NumberTriviaState, GetConcrete>(_getConcrete).call,
  TypedReducer<NumberTriviaState, GetRandom>(_getRandom).call,
  TypedReducer<NumberTriviaState, FetchSuccess>(_fetchSuccess).call,
  TypedReducer<NumberTriviaState, FetchFailed>(_fetchFailed).call,
]);

NumberTriviaState _getConcrete(NumberTriviaState state, GetConcrete action) {
  return Loading();
}

NumberTriviaState _getRandom(NumberTriviaState state, GetRandom action) {
  return Loading();
}

NumberTriviaState _fetchSuccess(NumberTriviaState state, FetchSuccess action) {
  return Loaded(numberTrivia: action.trivia);
}

NumberTriviaState _fetchFailed(NumberTriviaState state, FetchFailed action) {
  return Error(message: action.message);
}
