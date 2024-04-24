
import 'package:clean_flutter_tdd_ddd/core/localization/domain/entities/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LocalizationWidget extends HookWidget {

  final List<LocalizationLanguage> languagesArray = LocalizationLanguage.values;
  
  @override
  Widget build(BuildContext context) {
    final currentLanguageIndex = useState(0);
    final currentLanguage = languagesArray[currentLanguageIndex.value];

    int nextLanguageIndex() {
      return currentLanguageIndex.value = currentLanguageIndex.value >= languagesArray.length - 1 
        ? 0 
        : currentLanguageIndex.value + 1;
    } 

    void _onPressed() {
      currentLanguageIndex.value = nextLanguageIndex();
    }

    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ElevatedButton.icon(
          onPressed: _onPressed,
          icon: Icon(Icons.language),
          label: Container(
            width: double.infinity,
            child: Text(
              currentLanguage.languageCode.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(width: 1))
          ),
        ),
      ),
    );
  }
}