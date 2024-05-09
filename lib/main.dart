import 'package:clean_flutter_tdd_ddd/core/store/app_epic.dart';
import 'package:clean_flutter_tdd_ddd/core/store/app_state.dart';
import 'package:clean_flutter_tdd_ddd/core/store/app_state_reducer.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';
import 'injection_container.dart' as di;
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() async {
  await di.setup();

  final store = Store<AppState>(
    appReducer, 
    initialState: AppState(),
    middleware: [
      EpicMiddleware<AppState>(di.getIt<AppEpic>().combinedEpic),
      new LoggingMiddleware.printer()
    ]
  );

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({required this.store, super.key});

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
      )
    );
  }
}