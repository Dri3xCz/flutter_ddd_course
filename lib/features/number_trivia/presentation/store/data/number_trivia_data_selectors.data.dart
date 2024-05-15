
import 'package:reselect/reselect.dart';

import '../../../../../core/store/app_state.dart';
import '../number_trivia_selectors.dart';
import '../number_trivia_state.dart';
import 'number_trivia_data_state.dart';

final numberTriviaDataStateSelector = createSelector1<AppState, NumberTriviaState, NumberTriviaDataState>(
  numberTriviaStateSelector, 
  (numberTriviaState) => numberTriviaState.numberTriviaDataState,
);
