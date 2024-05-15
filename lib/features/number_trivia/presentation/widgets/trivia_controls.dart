import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart' as redux;

import '../../../../core/store/app_state.dart';
import '../store/data/number_trivia_data_actions.dart';
import '../store/form/number_trivia_form_actions.dart';
import '../store/form/number_trivia_form_selectors.dart';

class TriviaControls extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: '');

    return StoreConnector<AppState, redux.Store<AppState>>(
    converter: (store) => store,
    builder: (context, store) {
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
              store.dispatch(ChangeDataAction(value));
            },
            onSubmitted: (_) {
              store.dispatch(GetConcrete(formSelector(store.state)));
            },),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: formSelector(store.state) == '' ? null :
                  () => store.dispatch(GetConcrete(formSelector(store.state))),
                  child: const Text('Search'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => store.dispatch(GetRandom()),
                  child: const Text('Get random trivia'),
                ),
              ),
            ],
          ),
        ],
      );
    },);
  }
}
