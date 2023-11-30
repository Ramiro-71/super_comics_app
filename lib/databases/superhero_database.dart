import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SuperheroDatabase {
  final int version = 1;
  final String databaseName = "superhero.db";
  final String tableName = "superheroes";

  Database? db;

  Future<Database> openDb() async {
    db ??= await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (database, version) {
      database.execute(
          "create table $tableName (id integer primary key, name text, gender text, intelligence text, imageUrl text)");
    }, version: version);
    return db as Database;
  }
}
