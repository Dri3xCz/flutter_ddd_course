import 'dart:convert';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test text");

  test(
    'should be a subclass of NumberTrivia',
    () async {
      // assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        // arange 
        final Map<String, dynamic> jsonMap = 
          json.decode(fixture('trivia.json'));

        // act 
        final result = NumberTriviaModel.fromJson(jsonMap);

        // assert 
        expect(result, tNumberTriviaModel);
      }
    );

    test(
    'should return a valid model when the JSON number is regarded as a double',
    () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );
  });
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // arrange
        final expectedJsonMap = {
          "text": "Test text",
          "number": 1,
        };
        // act
        final result = tNumberTriviaModel.toJson();
        // assert
        expect(result, expectedJsonMap);
      },
    );
  });
}