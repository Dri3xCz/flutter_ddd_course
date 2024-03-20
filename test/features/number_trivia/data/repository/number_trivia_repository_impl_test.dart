import 'package:clean_flutter_tdd_ddd/core/platform/network_info.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaLocalDataSource>(),
  MockSpec<NumberTriviaRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])

void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() => {
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource(),
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource(),
    mockNetworkInfo = MockNetworkInfo(),
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockNumberTriviaRemoteDataSource,
      localDataSource: mockNumberTriviaLocalDataSource,
      networkInfo: mockNetworkInfo,
    ),
  });
}