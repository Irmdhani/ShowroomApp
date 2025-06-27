import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uas/car/car.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'car_database.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cars (
        id INTEGER,
        judul TEXT,
        harga TEXT,
        nomer TEXT,
        desc TEXT,
        gambar TEXT
      )
    ''');
  }

  Future<int> insertCar(Car car) async {
    Database db = await database;
    return db.insert('cars', car.toMap());
  }

  Future<List<Car>> getCars() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('cars');
    return List.generate(maps.length, (index) {
      return Car(
        id: maps[index]['id'],
        judul: maps[index]['judul'],
        harga: maps[index]['harga'],
        nomer: maps[index]['nomer'],
        desc: maps[index]['desc'],
        gambar: maps[index]['gambar'],
      );
    });
  }
}

//Mohamad Ilham Ramadhani - A11.2022.14587
