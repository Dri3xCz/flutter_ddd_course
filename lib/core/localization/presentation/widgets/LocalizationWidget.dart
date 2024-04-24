
import 'dart:collection';

import 'package:clean_flutter_tdd_ddd/core/localization/domain/entities/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension Rotate<T> on ListQueue<T> {
  T rotateLeft() {
    final value = this.removeFirst();
 
    this.addLast(value);
 
    return value;
  }
}

class LocalizationWidget extends HookWidget {

  final ListQueue<LocalizationLanguage> languageQueue = ListQueue.from(LocalizationLanguage.values);
  final LocalizationLanguage initialState = LocalizationLanguage.English;

  LocalizationWidget() {
    syncLanguageQueue();
  }

  void syncLanguageQueue() {
    while (initialState != languageQueue.last) {
        languageQueue.rotateLeft();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = useState(initialState);

    void _onPressed() {
      currentLanguage.value = languageQueue.rotateLeft();
    }

    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: OutlinedButton.icon(
          onPressed: _onPressed,
          icon: Icon(Icons.language),
          label: Container(
            width: double.infinity,
            child: Text(
              currentLanguage.value.languageCode.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}