import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../error/failures.dart';

@lazySingleton
class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final convertedNumber = int.parse(str);
      if (convertedNumber < 0) throw const FormatException();
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
