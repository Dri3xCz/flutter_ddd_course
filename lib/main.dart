import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';

import 'core/store/app_epic.dart';
import 'core/store/app_state.dart';
import 'core/store/app_state_reducer.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.setup();

  final store =
      Store<AppState>(appReducer, initialState: AppState(), middleware: [
    EpicMiddleware<AppState>(di.getIt<AppEpic>().combinedEpic).call,
    LoggingMiddleware<dynamic>.printer().call,
  ],);

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({required this.store, super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Number Trivia',
          theme: ThemeData(
            primaryColor: Colors.green.shade800,
            highlightColor: Colors.green.shade600,
          ),
          home: NumberTriviaPage(),
        ),);
  }
}
