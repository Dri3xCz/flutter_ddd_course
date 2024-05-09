import 'package:clean_flutter_tdd_ddd/core/error/failures.dart';
import 'package:clean_flutter_tdd_ddd/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<InputConverter>(),
])
void main() {
  late InputConverter inputConverter;

  setUp(() => {
        inputConverter = InputConverter(),
      },);

  group('string to unsigned int', () {
    test(
      'should return integer when string represents an unsigned integer',
      () async {
        // arrange
        const tStr = '123';
        const expectedResult = Right<Failure, int>(123);

        // act
        final result = inputConverter.stringToUnsignedInteger(tStr);

        // assert
        expect(result, expectedResult);
      },
    );

    test(
        "should return [InvalidInputFailure] when string doesn't represent integer",
        () async {
      // arrange
      const tStr = 'abc';
      final expectedResult = Left<Failure, int>(InvalidInputFailure());

      // act
      final result = inputConverter.stringToUnsignedInteger(tStr);

      // assert
      expect(result, expectedResult);
    });

    test(
      'should return a failure when the string is a negative integer',
      () async {
        // arrange
        const str = '-123';
        final expectedResult = Left<Failure, int>(InvalidInputFailure());

        // act
        final result = inputConverter.stringToUnsignedInteger(str);

        // assert
        expect(result, expectedResult);
      },
    );
  });
}
