import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_flutter_tdd_ddd/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: FutureBuilder(future: getIt.allReady(), builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildBody(context);
        } else return CircularProgressIndicator();
      },),
    );
  }
}

BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
  return BlocProvider(
    create: (_) => getIt<NumberTriviaBloc>(),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            // Top half
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
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
              },
            ),
            // Bottom half
           TriviaControls(), 
          ],
        ),
      ),
    ),
  );
}


