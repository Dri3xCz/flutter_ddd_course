import 'package:clean_flutter_tdd_ddd/core/error/failures.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaRepository>(),
])
void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetConcreteNumberTrivia usecase;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: tNumber, text: 'test');

  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange
      const expectedResult = Right<Failure, NumberTrivia>(tNumberTrivia);
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => expectedResult);

      // act
      final result =
          await usecase(const GetConcreteNumberTriviaParams(number: tNumber));

      //assert
      expect(result, expectedResult);
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
