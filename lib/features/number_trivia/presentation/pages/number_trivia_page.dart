import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../core/store/app_state.dart';
import '../store/data/number_trivia_state.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: buildBody(context),
    );
  }
}

StoreConnector<AppState, NumberTriviaState> buildBody(BuildContext context) {
  return StoreConnector<AppState, NumberTriviaState>(
    converter: (store) => store.state.numberTriviaState,
    builder: (context, state) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              numberTriviaStateContainer(context, state),
              TriviaControls(),
            ],
          ),
        ),
      );
    },
  );
}

Widget numberTriviaStateContainer(
    BuildContext context, NumberTriviaState state,) {
  return switch (state) {
    Empty() => const MessageDisplay(message: 'Start searching!'),
    Loading() => LoadingWidget(),
    Error() => MessageDisplay(message: state.message),
    Loaded() => TriviaDisplay(
        numberTrivia: state.numberTrivia,
      ),
  };
}
