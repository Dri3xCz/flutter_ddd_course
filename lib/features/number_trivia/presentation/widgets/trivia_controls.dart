import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../core/store/app_state.dart';
import '../store/data/number_trivia_data_actions.dart';

class TriviaControls extends StatefulWidget {
  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr = '';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(converter: (store) {
      return () => store.dispatch(GetConcrete(inputStr));
    }, builder: (context, dispatchConcrete) {
      return Column(
        children: <Widget>[
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Input a number',
            ),
            onChanged: (value) {
              inputStr = value;
            },
            onSubmitted: (_) {
              dispatchConcrete();
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: dispatchConcrete,
                  child: const Text('Search'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StoreConnector<AppState, VoidCallback>(
                    builder: (context, dispatchRandom) => ElevatedButton(
                          onPressed: dispatchRandom,
                          child: const Text('Get random trivia'),
                        ),
                    converter: (store) => () => store.dispatch(GetRandom()),),
              ),
            ],
          ),
        ],
      );
    },);
  }
}
