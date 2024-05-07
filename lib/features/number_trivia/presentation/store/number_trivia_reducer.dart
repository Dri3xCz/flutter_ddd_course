import 'package:redux/redux.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/number_trivia_actions.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/number_trivia_state.dart';

final numberTriviaReducer = combineReducers<NumberTriviaState>([
  TypedReducer<NumberTriviaState, GetConcrete>(_getConcrete),
  TypedReducer<NumberTriviaState, GetRandom>(_getRandom),
  TypedReducer<NumberTriviaState, FetchSuccess>(_fetchSuccess),
  TypedReducer<NumberTriviaState, FetchFailed>(_fetchFailed),
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