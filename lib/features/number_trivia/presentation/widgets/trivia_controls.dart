import 'package:clean_flutter_tdd_ddd/core/store/app_state.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/number_trivia_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TriviaControls extends StatefulWidget {
  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr = "";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (store) {
        return () => store.dispatch(GetConcrete(inputStr));
      },
      builder: (context, dispatchConcrete) {
      return Column(
        children: <Widget>[
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number',
            ),
            onChanged: (value) {
              inputStr = value;
            },
            onSubmitted: (_) {
              dispatchConcrete;
            },
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  child: Text('Search'),
                  onPressed: dispatchConcrete,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: StoreConnector<AppState, VoidCallback>(builder: (context, dispatchRandom) => ElevatedButton(
                    child: Text('Get random trivia'),
                    onPressed: dispatchRandom,
                  ), converter: (store) => () => store.dispatch(GetRandom())
                ),
              )
            ],
          )
        ],
      );
    });
  }
}