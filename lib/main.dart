import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uas/server/login.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() async {
  sqflite.databaseFactory = databaseFactoryFfiWeb;

  WidgetsFlutterBinding.ensureInitialized();
  await sqflite.openDatabase('car_database.db', version: 1,
      onCreate: (Database db, int version) async {
    // Buat tabel atau lakukan inisialisasi lainnya di sini
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
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Jual Beli Mobil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

//Mohamad Ilham Ramadhani - A11.2022.14587