
import 'data/number_trivia_data_reducer.dart';
import 'form/number_trivia_form_reducer.dart';
import 'number_trivia_state.dart';

NumberTriviaState numberTriviaReducer(NumberTriviaState state, dynamic action) {
  return NumberTriviaState(
    numberTriviaDataReducer(state.numberTriviaDataState, action), 
    numberTriviaFormReducer(state.numberTriviaFormState, action),
  );
}