import 'package:clean_flutter_tdd_ddd/core/store/app_state.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/number_trivia_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: buildBody(context)
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
              SizedBox(height: 10),
              numberTriviaStateContainer(context, state) ,
              TriviaControls(), 
            ],
          ),
        ),
      );
    },
  );
}

Widget numberTriviaStateContainer(BuildContext context, NumberTriviaState state) {
  if (state is Empty) {
    return MessageDisplay(message: 'Start searching!');
  } else if (state is Error) {
    return MessageDisplay(message: state.message);
  } else if (state is Loading) {
    return LoadingWidget();
  } else if (state is Loaded) {
    return TriviaDisplay(numberTrivia: state.numberTrivia);
  } else {
    return MessageDisplay(message: "Something went wrong");
  } 
}


