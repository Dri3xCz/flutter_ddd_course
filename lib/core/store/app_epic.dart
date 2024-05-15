import 'package:injectable/injectable.dart';
import 'package:redux_epics/redux_epics.dart';

import '../../features/number_trivia/presentation/store/data/number_trivia_epic.dart';
import 'app_state.dart';

@lazySingleton
class AppEpic {
  final NumberTriviaEpic<AppState> numberTriviaEpic;

  AppEpic({required this.numberTriviaEpic});

  Epic<AppState> get combinedEpic => combineEpics([numberTriviaEpic.call]);
}
