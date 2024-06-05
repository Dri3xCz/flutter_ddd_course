import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/mapper/number_trivia_mapper.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NumberTriviaMapper numberTriviaMapper;

  setUp(() => numberTriviaMapper = NumberTriviaMapper());

  test(
    'should return NumberTrivia when converting NumberTriviaModel',
    () async {
      // arrange
      const tNumberTriviaModel =
          NumberTriviaModel(text: 'test trivia', number: 123);
      const expectedResult = NumberTrivia(text: 'test trivia', number: 123);

      // act
      final result = numberTriviaMapper
          .convert<NumberTriviaModel, NumberTrivia>(tNumberTriviaModel);

      // assert
      expect(result, expectedResult);
    },
  );

  test(
    'should throw [Exception] when converting null',
    () async {
      // act
      final call = numberTriviaMapper.convert<NumberTriviaModel, NumberTrivia>;

      // assert
      expect(() => call(null), throwsException);
    },
  );
}
