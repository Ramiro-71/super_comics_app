import 'dart:core';

class Superhero {
  final int id;
  final String name;
  final String gender;
  final String intelligence;
  final String imageUrl;

  Superhero(
      {required this.id,
      required this.name,
      required this.gender,
      required this.intelligence,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'intelligence': intelligence,
      'imageUrl': imageUrl,
    };
  }

  factory Superhero.fromJson(Map<String, dynamic> json) {
    return Superhero(
      id: int.parse(json['id'] ?? '0'),
      name: json['name'] ?? '',
      gender: json['appearance']['gender'] ?? '',
      intelligence: json['powerstats']['intelligence'] ?? '',
      imageUrl: json['image']['url'] ?? '',
    );
  }

  factory Superhero.fromMap(Map<String, dynamic> map) {
    return Superhero(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      intelligence: map['intelligence'],
      imageUrl: map['imageUrl'],
    );
  }
}
