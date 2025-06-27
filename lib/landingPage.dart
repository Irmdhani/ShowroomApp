// lib/landingPage.dart
import 'package:flutter/material.dart';
import 'package:uas/car/home_page.dart';
import 'package:uas/car/jual.dart';
import 'package:uas/profile/profile.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // Daftar halaman yang akan ditampilkan
  final List<Widget> _pages = [
    HomePage(),
    Jual(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Luxury Cars Showroom'),
        backgroundColor: Colors.blueGrey[800], // Warna primer konsisten
        elevation: 0,
      ),
      // Body akan menampilkan halaman sesuai index yang dipilih
      body: _pages[_currentIndex],
      backgroundColor: Colors.grey[100], // Latar belakang utama
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.amber[800], // Warna aksen untuk item aktif
        unselectedItemColor: Colors.blueGrey[600],
        backgroundColor: Colors.white, // Latar belakang navigasi
        type: BottomNavigationBarType.fixed, // Agar label selalu terlihat
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined),
            activeIcon: Icon(Icons.directions_car),
            label: 'Cars',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Jual',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}