// lib/car/home_page.dart
import 'package:flutter/material.dart';
import 'package:uas/car/car.dart';
import 'package:uas/databases/databaseHelper.dart';
import 'package:uas/car/list_car.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<Car>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _carsFuture = _dbHelper.getCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<Car>>(
          future: _carsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(height: MediaQuery.of(context).size.height * 0.7, alignment: Alignment.center, child: Text('Belum ada mobil.\nGeser ke bawah untuk refresh.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600]))),
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final car = snapshot.data![index];
                  return ListItem(car: car, onDataChanged: _refreshData);
                },
              );
            }
          },
        ),
      ),
    );
  }
}