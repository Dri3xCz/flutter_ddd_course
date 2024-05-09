import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

@lazySingleton
class GetConcreteNumberTrivia
    implements UseCase<NumberTrivia, GetConcreteNumberTriviaParams> {
  final NumberTriviaRepository repository;

  const GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(
      GetConcreteNumberTriviaParams params,) async {
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
