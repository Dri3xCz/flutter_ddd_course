import '../../features/number_trivia/presentation/store/number_trivia_state.dart';

final class AppState {
  final NumberTriviaState numberTriviaState;

  AppState({this.numberTriviaState = const Empty()});
}
