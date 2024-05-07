
import 'package:clean_flutter_tdd_ddd/core/error/failures.dart';
import 'package:clean_flutter_tdd_ddd/core/usecases/usecase.dart';
import 'package:clean_flutter_tdd_ddd/core/util/input_converter.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/presentation/store/number_trivia_actions.dart';
import 'package:dartz/dartz.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/transformers.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';


class NumberTriviaEpic<T> implements EpicClass<T> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter; 

  NumberTriviaEpic({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) {}

  Stream<NumberTriviaAction> _handleUsecase(
    Future<Either<Failure, NumberTrivia>> useCase
  ) async* {
    final failureOrTrivia = await useCase;
    
    yield failureOrTrivia.fold(
      (failure) {
        final message = failure is ServerFailure
          ? SERVER_FAILURE_MESSAGE
          : CACHE_FAILURE_MESSAGE; 
        return FetchFailed(message);
      },
      (numberTrivia) => FetchSuccess(numberTrivia)
    );
  }

  Stream<NumberTriviaAction> _handleConcrete(String numberString) async* {
    final inputEither = inputConverter.stringToUnsignedInteger(numberString);
      
    inputEither.fold(
      (failure) sync* { 
        yield FetchFailed(INVALID_INPUT_FAILURE_MESSAGE);
      },
      (integer) async* {
        yield* _handleUsecase(getConcreteNumberTrivia(GetConcreteNumberTriviaParams(number: integer)));
      }
    );
  }
  
  _handleActionType(NumberTriviaAction action) async {
    if (action is GetConcrete) await _handleConcrete(action.numberString);
    if (action is GetRandom) await _handleUsecase(getRandomNumberTrivia(NoParams()));
  }

  @override
  Stream call(Stream actions, EpicStore<T> store) {
    return actions.whereType<NumberTriviaAction>()
    .asyncMap((action) async* {
      yield _handleActionType(action);
    });
  }
}