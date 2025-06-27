// lib/main.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:uas/server/login.dart';

void main() {
  // Hanya inisialisasi FFI untuk platform web.
  // Ini tidak akan berpengaruh pada build iOS.
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luxury Cars Showroom',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[800],
          elevation: 0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}