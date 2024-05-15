
import 'package:redux/redux.dart';

import 'number_trivia_form_actions.dart';
import 'number_trivia_form_state.dart';

final numberTriviaFormReducer = combineReducers([
  TypedReducer<NumberTriviaFormState, ChangeDataAction>(_changeDataReducer).call,
],);

NumberTriviaFormState _changeDataReducer(NumberTriviaFormState state, ChangeDataAction action) {
  return NumberTriviaFormState(action.data);
}
