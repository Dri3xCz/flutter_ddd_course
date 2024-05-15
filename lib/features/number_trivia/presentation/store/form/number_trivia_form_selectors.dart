
import 'package:reselect/reselect.dart';

import '../../../../../core/store/app_state.dart';
import '../number_trivia_selectors.dart';
import '../number_trivia_state.dart';
import 'number_trivia_form_state.dart';

final numberTriviaFormStateSelector = createSelector1<AppState, NumberTriviaState, NumberTriviaFormState>(
  numberTriviaStateSelector,
  (numberTriviaState) => numberTriviaState.numberTriviaFormState,
);

final formSelector = createSelector1<AppState, NumberTriviaFormState, String>(
  numberTriviaFormStateSelector,
  (numberTriviaFormState) => numberTriviaFormState.form,
);
