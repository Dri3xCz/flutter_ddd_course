import 'package:clean_flutter_tdd_ddd/core/error/failures.dart';
import 'package:clean_flutter_tdd_ddd/core/usecases/usecase.dart';
import 'package:clean_flutter_tdd_ddd/core/util/input_converter.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<InputConverter>(),
  MockSpec<GetConcreteNumberTrivia>(),
  MockSpec<GetRandomNumberTrivia>(),
])

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  }); 

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    // The event takes in a String
    final tNumberString = '1';
    // This is the successful output of the InputConverter
    final tNumberParsed = int.parse(tNumberString);
    // NumberTrivia instance is needed too, of course
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(any))
        .thenReturn(Right(tNumberParsed));
    }
    void setUpMockGetConcreteNumberTriviaSuccess() {
      when(mockGetConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));
    }

    test(
      'should call the InputConverter to validate and convert the string to an unsigned integer',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();

        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        final expectedStates = [
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        final result = bloc.stream;

        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));

        // assert 
        expect(result, emitsInOrder(expectedStates));
      },
    );

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));
        await untilCalled(mockGetConcreteNumberTrivia(any));
        // assert
        verify(mockGetConcreteNumberTrivia(GetConcreteNumberTriviaParams(number: tNumberParsed)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        setUpMockGetConcreteNumberTriviaSuccess();
        
        final expectedStates = [
          Loading(),
          Loaded(numberTrivia: tNumberTrivia),
        ];
        final result = bloc.stream;
        
        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));

        // assert
        expect(result, emitsInOrder(expectedStates));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        final expectedStates = [
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        final result = bloc.stream;

        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));

        // assert 
        expect(result, emitsInOrder(expectedStates));
      },
    );   

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expectedStates = [
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        final result = bloc.stream;

        // act
        bloc.add(GetTriviaForConcreteNumber(tNumberString));

        // assert
        expect(result, emitsInOrder(expectedStates));
      },
    ); 
  });

  group('GetTriviaForRandomNumber', () {
    // NumberTrivia instance is needed too, of course
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');
    
    void setUpMockGetRandomNumberTriviaSuccess() {
      when(mockGetRandomNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));
    }
    test(
      'should get data from the random use case',
      () async {
        // arrange
        setUpMockGetRandomNumberTriviaSuccess();
        // act
        bloc.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockGetRandomNumberTriviaSuccess();
        final expectedStates = [
          Loading(),
          Loaded(numberTrivia: tNumberTrivia),
        ];
        final result = bloc.stream;
        
        // act
        bloc.add(GetTriviaForRandomNumber());

        // assert
        expect(result, emitsInOrder(expectedStates));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        final expectedStates = [
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        final result = bloc.stream;

        // act
        bloc.add(GetTriviaForRandomNumber());

        // assert 
        expect(result, emitsInOrder(expectedStates));
      },
    );   

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expectedStates = [
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        final result = bloc.stream;

        // act
        bloc.add(GetTriviaForRandomNumber());

        // assert
        expect(result, emitsInOrder(expectedStates));
      },
    ); 
  });
}