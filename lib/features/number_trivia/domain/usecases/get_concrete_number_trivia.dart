import 'package:clean_flutter_tdd_ddd/core/error/failures.dart';
import 'package:clean_flutter_tdd_ddd/core/usecases/usecase.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, GetConcreteNumberTriviaParams> {
  final NumberTriviaRepository repository;

  const GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(GetConcreteNumberTriviaParams params) async {
    return repository.getConcreteNumberTrivia(
      params.number,
    );
  }
}

final class GetConcreteNumberTriviaParams extends Equatable {
  final int number;

  const GetConcreteNumberTriviaParams({required this.number});

  @override
  List<Object?> get props => [number];
}
