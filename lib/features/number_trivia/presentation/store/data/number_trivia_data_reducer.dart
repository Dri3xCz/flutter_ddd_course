import 'package:redux/redux.dart';

import 'number_trivia_data_actions.dart';
import 'number_trivia_data_state.dart';

final numberTriviaDataReducer = combineReducers<NumberTriviaDataState>([
  TypedReducer<NumberTriviaDataState, GetConcrete>(_getConcrete).call,
  TypedReducer<NumberTriviaDataState, GetRandom>(_getRandom).call,
  TypedReducer<NumberTriviaDataState, FetchSuccess>(_fetchSuccess).call,
  TypedReducer<NumberTriviaDataState, FetchFailed>(_fetchFailed).call,
]);

NumberTriviaDataState _getConcrete(NumberTriviaDataState state, GetConcrete action) {
  return Loading();
}

NumberTriviaDataState _getRandom(NumberTriviaDataState state, GetRandom action) {
  return Loading();
}

NumberTriviaDataState _fetchSuccess(NumberTriviaDataState state, FetchSuccess action) {
  return Loaded(numberTrivia: action.trivia);
}

NumberTriviaDataState _fetchFailed(NumberTriviaDataState state, FetchFailed action) {
  return Error(message: action.message);
}
