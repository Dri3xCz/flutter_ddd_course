
import 'data/number_trivia_data_state.dart';
import 'form/number_trivia_form_state.dart';

final class NumberTriviaState {
  final NumberTriviaDataState numberTriviaDataState;
  final NumberTriviaFormState numberTriviaFormState;

  const NumberTriviaState(this.numberTriviaDataState, this.numberTriviaFormState);
}
