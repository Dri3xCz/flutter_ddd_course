import 'dart:convert';

import 'package:clean_flutter_tdd_ddd/core/error/exception.dart';
import 'package:http/http.dart' as http;
import '../models/number_trivia_model.dart';

abstract interface class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  const NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });

  Future<NumberTriviaModel> _getTriviaFromUri(Uri uri) async {
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
    
    return NumberTriviaModel.fromJson(json.decode(response.body));
  }

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getTriviaFromUri(Uri.http("numbersapi.com", "$number"));
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return _getTriviaFromUri(Uri.http("numbersapi.com", "random"));
  }
}
