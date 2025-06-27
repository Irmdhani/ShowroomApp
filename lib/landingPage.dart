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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Luxury Cars Showroom'),
        backgroundColor: Color.fromRGBO(225, 176, 29, 1),
      ),
      body: _buildPage(_currentIndex),
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Color.fromRGBO(225, 176, 29, 1),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Cars',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sell),
            label: 'Jual',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return AddItem();
      case 2:
        return Profile();
      default:
        return Container(); // Return a default empty container if index is out of bounds.
    }
  }
}

//Mohamad Ilham Ramadhani - A11.2022.14587