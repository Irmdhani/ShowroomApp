// lib/databases/DatabaseHelper.dart
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uas/car/car.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static Completer<Database>? _dbCompleter;

  Future<Database> get database async {
    if (_database != null) return _database!;
    if (_dbCompleter != null) return _dbCompleter!.future;

    _dbCompleter = Completer<Database>();
    _database = await _initDatabase();
    _dbCompleter!.complete(_database);
    return _database!;
  }

  Future<Database> _initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    String path = join(await getDatabasesPath(), 'car_database.db');
    
    return openDatabase(
      path,
      version: 3, // Naikkan versi untuk memicu onUpgrade
      onCreate: _createDatabase,
      onUpgrade: _onUpgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    print("--- DatabaseHelper: Menjalankan _createDatabase (v3) ---");
    await _createTables(db);
  }

  Future<void> _onUpgradeDatabase(Database db, int oldVersion, int newVersion) async {
    print("--- DatabaseHelper: Menjalankan _onUpgradeDatabase dari v$oldVersion ke v$newVersion ---");
    await db.execute("DROP TABLE IF EXISTS cars");
    await _createTables(db);
  }
  
  Future<void> _createTables(Database db) async {
     await db.execute('''
      CREATE TABLE cars (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT NOT NULL,
        harga TEXT NOT NULL,
        nomer TEXT NOT NULL,
        desc TEXT NOT NULL,
        gambar TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertCar(Car car) async {
    Database db = await database;
    return db.insert('cars', car.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Car>> getCars() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('cars', orderBy: 'id DESC');
      return List.generate(maps.length, (i) {
        return Car.fromMap(maps[i]);
      });
    } catch (e) {
      print("Error saat getCars: $e");
      return [];
    }
  }

  Future<int> updateCar(Car car) async {
    Database db = await database;
    return await db.update('cars', car.toMap(), where: 'id = ?', whereArgs: [car.id]);
  }

  Future<int> deleteCar(int id) async {
    Database db = await database;
    return await db.delete('cars', where: 'id = ?', whereArgs: [id]);
  }
}