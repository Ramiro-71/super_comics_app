import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:super_comics_app/models/superhero.dart';

class SuperheroService {
  late final String _token;
  late final String baseUrl;

  SuperheroService(String token) {
    _token = token;
    baseUrl = "https://superheroapi.com/api/$_token";
  }

  Future<List<Superhero>?> getByName(String name) async {
    http.Response response = await http.get(Uri.parse("$baseUrl/search/$name"));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      log(response.body);
      final List maps = jsonResponse["results"];
      final superheroes = maps.map((e) => Superhero.fromJson(e)).toList();
      print(superheroes);
      return superheroes;
    }
    print("Failed to load superheroes: ${response.statusCode}");
    return null;
  }

  Future<Superhero> getById(String id) async {
    http.Response response = await http.get(Uri.parse("$baseUrl$id"));

    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      final superhero = Superhero.fromJson(jsonResponse);
      print(superhero);
      return superhero;
    }
    throw Exception('Failed to load superhero');
  }
}
