import 'package:clean_flutter_tdd_ddd/core/error/failures.dart';
import 'package:clean_flutter_tdd_ddd/core/usecases/usecase.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  const GetRandomNumberTrivia(this.repository);
  
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams) {
    return repository.getRandomNumberTrivia();
  }
}

