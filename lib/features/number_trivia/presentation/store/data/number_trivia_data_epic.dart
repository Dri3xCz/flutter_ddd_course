import 'package:dartz/dartz.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/transformers.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/util/input_converter.dart';
import '../../../domain/entities/number_trivia.dart';
import '../../../domain/usecases/get_concrete_number_trivia.dart';
import '../../../domain/usecases/get_random_number_trivia.dart';
import 'number_trivia_data_actions.dart';

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
  });

  Stream<NumberTriviaAction> _handleUsecase(
      Future<Either<Failure, NumberTrivia>> useCase,) async* {
    final failureOrTrivia = await useCase;

    yield failureOrTrivia.fold(
      (failure) {
        final message = failure is ServerFailure
            ? SERVER_FAILURE_MESSAGE
            : CACHE_FAILURE_MESSAGE;

        return FetchFailed(message);
      },
      FetchSuccess.new,
    );
  }

  Stream<NumberTriviaAction> _handleConcrete(String numberString) async* {
    final inputEither = inputConverter.stringToUnsignedInteger(numberString);

    yield* inputEither.fold(
      (failure) async* {
        yield const FetchFailed(INVALID_INPUT_FAILURE_MESSAGE);
      },
      (integer) async* {
        yield* _handleUsecase(
          getConcreteNumberTrivia(
            GetConcreteNumberTriviaParams(number: integer),
          ),
        );
      },
    );
  }

  Stream<NumberTriviaAction> _handleActionType(NumberTriviaAction action) {
    return switch (action) {
      GetConcrete() => _handleConcrete(action.numberString),
      GetRandom() => _handleUsecase(getRandomNumberTrivia(const NoParams())),
      _ => const Stream.empty(),
    };
  }

  @override
  Stream<dynamic> call(Stream<dynamic> actions, EpicStore<T> store) {
    return actions.whereType<NumberTriviaAction>().switchMap(_handleActionType);
  }
}
