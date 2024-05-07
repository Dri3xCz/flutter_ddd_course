import 'package:clean_flutter_tdd_ddd/core/store/app_state.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/number_trivia_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    numberTriviaState: numberTriviaReducer(state.numberTriviaState, action) 
  );
}