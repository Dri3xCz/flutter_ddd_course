import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure([List properties = const<dynamic>[]]);
}

final class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

final class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}