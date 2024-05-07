import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/number_trivia_state.dart';

final class AppState {
  final NumberTriviaState numberTriviaState;

  AppState({this.numberTriviaState = const Empty()});
}