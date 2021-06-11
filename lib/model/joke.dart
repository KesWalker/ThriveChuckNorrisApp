import 'dart:core';

class Joke {
  final int id;
  final String joke;
  final List<dynamic> categories;

  Joke({
    required this.id,
    required this.joke,
    required this.categories
  });

  factory Joke.fromJson(Map<String, dynamic> json){
    return Joke(
        id: json['id'], joke: json['joke'], categories: json['categories']);
  }
}