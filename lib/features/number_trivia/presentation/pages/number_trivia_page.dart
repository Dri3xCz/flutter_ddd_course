import 'package:clean_flutter_tdd_ddd/core/components/SettingsDrawer.dart';
import 'package:clean_flutter_tdd_ddd/core/localization/presentation/widgets/LocalizationWidget.dart';
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
      body: buildBody(context),
      drawer: SettingsDrawer(
        mainWidgets: [],
        bottomWidget: LocalizationWidget(),
      ), 
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
                return switch (state) {
                  Empty() => const MessageDisplay(message: 'Start searching!'),
                  Error(:final message) => MessageDisplay(message: message),
                  Loading() => const LoadingWidget(),
                  Loaded(:final numberTrivia) => TriviaDisplay(
                      numberTrivia: numberTrivia,
                    ),
                };
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
