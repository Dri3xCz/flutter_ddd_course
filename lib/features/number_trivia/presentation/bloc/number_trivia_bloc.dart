import 'package:bloc/bloc.dart';
import 'package:clean_flutter_tdd_ddd/core/error/failures.dart';
import 'package:clean_flutter_tdd_ddd/core/usecases/usecase.dart';
import 'package:clean_flutter_tdd_ddd/core/util/input_converter.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter; 

  Future<void> _handleUsecase(
    Emitter emit, Future<Either<Failure, NumberTrivia>> useCase
  ) async {
    emit(Loading());
    final failureOrTrivia = await useCase;
    
    failureOrTrivia.fold(
      (failure) {
        final message = failure is ServerFailure
          ? SERVER_FAILURE_MESSAGE
          : CACHE_FAILURE_MESSAGE; 
        emit(Error(message: message));
      },
      (numberTrivia) => emit(Loaded(numberTrivia: numberTrivia))
    );
  }

  Future<void> _handleConcrete(Emitter emit, String numberString) async {
    final inputEither = inputConverter.stringToUnsignedInteger(numberString);
      
    await inputEither.fold(
      (failure) async => emit(Error(message: INVALID_INPUT_FAILURE_MESSAGE)),
      (integer) async {
        await _handleUsecase(emit, getConcreteNumberTrivia(GetConcreteNumberTriviaParams(number: integer))); 
      }
    );
  }

  final initialState = Empty();

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      await _handleConcrete(emit, event.numberString);
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      await _handleUsecase(emit, getRandomNumberTrivia(NoParams()));  
    }); 
  }
}
