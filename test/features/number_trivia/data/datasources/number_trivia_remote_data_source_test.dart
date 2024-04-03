import 'dart:convert';
import 'package:clean_flutter_tdd_ddd/core/error/exception.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_flutter_tdd_ddd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<http.Client>(),
])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(
      mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        fixture('trivia.json'),
        200,
      ),
    );
  }

  void setUpMockHttpClientSuccess404() {
    when(
      mockHttpClient.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => http.Response(
        "Something went wrong!", 
        404,
      ),
    );
  }



  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
      NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        // arrange
        final expectedUri = Uri.http("numbersapi.com", "$tNumber");

        // mock
        setUpMockHttpClientSuccess200();

        // act
        dataSource.getConcreteNumberTrivia(tNumber);

        // assert
        verify(mockHttpClient.get(
          expectedUri,
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        // mock
        setUpMockHttpClientSuccess200();

        // act
        final result = await dataSource.getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      "should throw a ServerException when the response code is 404 or other",
      () async {
        // arrange
        // mock
        setUpMockHttpClientSuccess404();

        // act
        final call = dataSource.getConcreteNumberTrivia;

        // assert 
        expect(() => call(tNumber), throwsA(isA<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
      NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      'should preform a GET request on a URL with random number endpoint and with application/json header',
      () {
        // arrange
        final expectedUri = Uri.http("numbersapi.com", "random");

        // mock
        setUpMockHttpClientSuccess200();

        // act
        dataSource.getRandomNumberTrivia();

        // assert
        verify(mockHttpClient.get(
          expectedUri,
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        // mock
        setUpMockHttpClientSuccess200();

        // act
        final result = await dataSource.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      "should throw a ServerException when the response code is 404 or other",
      () async {
        // arrange
        // mock
        setUpMockHttpClientSuccess404();

        // act
        final call = dataSource.getRandomNumberTrivia;

        // assert 
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });
}
