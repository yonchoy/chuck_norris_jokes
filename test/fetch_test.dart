import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../lib/models/joke.dart';

Future<Joke> fetchJoke(http.Client client) async {
  final response =
      await http.get('https://api.chucknorris.io/jokes/random?category=dev');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Joke.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load a joke');
  }
}


class MockClient extends Mock implements http.Client {}

void main() {
  group('fetchPost', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client
      when(client.get('https://api.chucknorris.io/jokes/random?category=dev'))
          .thenAnswer((_) async => http.Response('{"iconUrl": "https://assets.chucknorris.host/img/avatar/chuck-norris.png"}', 200));

      expect(await fetchJoke(client), isInstanceOf<Joke>());
    });

    // test('throws an exception if the http call completes with an error', () {
    //   final client = MockClient();

    //   // Use Mockito to return an unsuccessful response when it calls the
    //   // provided http.Client
    //   when(client.get('https://api.chucknorris.io/jokes/random?category=dev'))
    //       .thenAnswer((_) async => http.Response('Not Found', 404));

    //   expect(fetchJoke(client), throwsException);
    // });
  });
}