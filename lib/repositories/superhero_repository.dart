import 'package:super_comics_app/models/superhero.dart';
import 'package:super_comics_app/databases/superhero_database.dart';
import 'package:sqflite/sqflite.dart';

class SuperheroRepository {
  Future insert(Superhero superhero) async {
    Database db = await SuperheroDatabase().openDb();
    db.insert(SuperheroDatabase().tableName, superhero.toMap());
  }

  Future delete(Superhero superhero) async {
    Database db = await SuperheroDatabase().openDb();
    db.delete(SuperheroDatabase().tableName,
        where: "id=?", whereArgs: [superhero.id]);
  }

  Future<bool> isFavorite(Superhero superhero) async {
    Database db = await SuperheroDatabase().openDb();
    final maps = await db.query(SuperheroDatabase().tableName,
        where: "id=?", whereArgs: [superhero.id]);
    return maps.isNotEmpty;
  }

  Future<List<Superhero>> getAll() async {
    Database db = await SuperheroDatabase().openDb();
    final maps = await db.query(SuperheroDatabase().tableName);
    return maps.map((map) => Superhero.fromMap(map)).toList();
  }
}
