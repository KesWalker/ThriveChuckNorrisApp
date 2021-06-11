import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thrive_chuck_norris_kw/model/joke.dart';

class ChuckRepo {
  Future<Joke> getJoke(Map<String, dynamic> params) async {

    final res = await http.get(Uri.parse("http://api.icndb.com/jokes/random?" +
        Uri(queryParameters: params).query));
    // not the best way of adding query parameters to http request but the
    // 'Uri.https()' method was not working for some reason.

    if (res.statusCode == 200) {
      return Joke.fromJson(jsonDecode(res.body)['value']);
    } else {
      throw Exception(
          "Couldn't get random joke, status code: ${res.statusCode}");
    }
  }

  Future<List<Joke>> getJokes(int page) async {
    final res = await http.get(Uri.parse("http://api.icndb.com/jokes/random/${page * 20}"));

    if (res.statusCode == 200) {
      List<Joke> jokes = [];
      Map<String, dynamic> json = jsonDecode(res.body);

      for(dynamic j in json['value']){
        jokes.add(Joke.fromJson(j));
      }

      return jokes;
    } else {
      throw Exception(
          "Couldn't get random joke, status code: ${res.statusCode}");
    }
  }
}
