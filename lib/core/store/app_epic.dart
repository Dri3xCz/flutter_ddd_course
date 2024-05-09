import 'package:redux_epics/redux_epics.dart';

import '../../features/number_trivia/presentation/store/number_trivia_epic.dart';
import 'app_state.dart';

class AppEpic {
  final NumberTriviaEpic<AppState> numberTriviaEpic;

  AppEpic({required this.numberTriviaEpic});

  Epic<AppState> get combinedEpic => combineEpics([numberTriviaEpic.call]);
}
