
import 'package:clean_flutter_tdd_ddd/core/store/app_state.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/number_trivia_epic.dart';
import 'package:redux_epics/redux_epics.dart';

class AppEpic {
  final NumberTriviaEpic numberTriviaEpic;

  AppEpic({required this.numberTriviaEpic});

  Epic<AppState> get combinedEpic => combineEpics([
    numberTriviaEpic
  ]);
}