
import 'package:clean_flutter_tdd_ddd/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

final class NoParams extends Equatable {

  const NoParams();

  @override
  List<Object?> get props => [];
}