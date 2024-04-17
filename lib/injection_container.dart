import "package:clean_flutter_tdd_ddd/core/network/network_info.dart";
import "package:clean_flutter_tdd_ddd/core/util/input_converter.dart";
import "package:clean_flutter_tdd_ddd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart";
import "package:clean_flutter_tdd_ddd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart";
import "package:clean_flutter_tdd_ddd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart";
import "package:clean_flutter_tdd_ddd/features/number_trivia/domain/repositories/number_trivia_repository.dart";
import "package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart";
import "package:clean_flutter_tdd_ddd/features/number_trivia/domain/usecases/get_random_number_trivia.dart";
import "package:clean_flutter_tdd_ddd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart";
import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:internet_connection_checker/internet_connection_checker.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:http/http.dart" as http;

final getIt = GetIt.instance;

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  // features: Number Trivia
  // Bloc
  getIt.registerFactory(() => NumberTriviaBloc(
    getConcreteNumberTrivia: getIt(),
    getRandomNumberTrivia: getIt(),
    inputConverter: getIt(),
  ));

  // Use cases
  getIt.registerLazySingleton(() => GetConcreteNumberTrivia(getIt()));
  getIt.registerLazySingleton(() => GetRandomNumberTrivia(getIt()));

  // Repository
  getIt.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: getIt()),
  );

  getIt.registerSingletonAsync<NumberTriviaLocalDataSource>(
    () async => NumberTriviaLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance(),)
  );

  //! Core
  getIt.registerLazySingleton(() => InputConverter());

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //! External
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton(() => InternetConnectionChecker()); 
}