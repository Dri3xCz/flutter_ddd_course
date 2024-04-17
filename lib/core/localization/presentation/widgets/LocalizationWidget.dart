
import 'package:clean_flutter_tdd_ddd/core/localization/domain/entities/localization.dart';
import 'package:flutter/material.dart';

class LocalizationWidget extends StatefulWidget {

  @override
  State<LocalizationWidget> createState() => _LocalizationWidgetState();
}

class _LocalizationWidgetState extends State<LocalizationWidget> {
  List<LocalizationLanguage> languagesArray = LocalizationLanguage.values;
  
  // State that will be handled by redux in future
  LocalizationLanguage currentLanguage = LocalizationLanguage.English;
  int currentIndex = 0;

  LocalizationLanguage nextLanguage() {
    currentIndex = currentIndex >= languagesArray.length - 1 
      ? 0 
      : currentIndex + 1;
    return languagesArray[currentIndex];
  } 

  void _onPressed() {
    setState(() {
      currentLanguage = nextLanguage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: _onPressed,
          child: Row(
            children: [
              Icon(
                Icons.language,
                size: 48,
              ),
              SizedBox(width: 12,),
              Text(
                currentLanguage.languageCode,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}