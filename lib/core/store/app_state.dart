import '../../features/number_trivia/presentation/store/data/number_trivia_data_state.dart';
import '../../features/number_trivia/presentation/store/form/number_trivia_form_state.dart';
import '../../features/number_trivia/presentation/store/number_trivia_state.dart';

final class AppState {
  final NumberTriviaState numberTriviaState;

  AppState({this.numberTriviaState = const NumberTriviaState(Empty(), NumberTriviaFormState(''),),});
}
