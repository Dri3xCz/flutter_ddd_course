import 'package:clean_flutter_tdd_ddd/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final convertedNumber = int.parse(str);
      if (convertedNumber < 0) throw FormatException();
      return Right(convertedNumber);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

final class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [];
}