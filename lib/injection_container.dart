import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/store/app_epic.dart';
import 'core/store/app_state.dart';
import 'core/util/input_converter.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/store/number_trivia_epic.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  // features: Number Trivia
  // Redux
  getIt..registerLazySingleton(() => AppEpic(numberTriviaEpic: getIt()))

  ..registerLazySingleton(() => NumberTriviaEpic<AppState>(
      getConcreteNumberTrivia: getIt(),
      getRandomNumberTrivia: getIt(),
      inputConverter: getIt(),),)

  // Use cases
  ..registerLazySingleton(() => GetConcreteNumberTrivia(getIt()))
  ..registerLazySingleton(() => GetRandomNumberTrivia(getIt()))

  // Repository
  ..registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  )

  // Data sources
  ..registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: getIt()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  getIt..registerLazySingleton<NumberTriviaLocalDataSource>(() =>
      NumberTriviaLocalDataSourceImpl(sharedPreferences: sharedPreferences),)

  //! Core
  ..registerLazySingleton(InputConverter.new)

  ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()))

  //! External
  ..registerLazySingleton(http.Client.new)
  ..registerLazySingleton(InternetConnectionChecker.new);
}
