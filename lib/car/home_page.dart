import 'package:flutter/material.dart';
import 'package:uas/car/car.dart';
import 'package:uas/databases/databaseHelper.dart';
import 'package:uas/car/list_car.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Car>>(
      future: DatabaseHelper().getCars(), // Mengambil data dari database
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('Belum ada data di database.');
        } else {
          // Menampilkan daftar mobil dari database
          return ListView.builder(
            itemCount: snapshot.data!.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return ListItem(
                judul: snapshot.data![index].judul,
                harga: snapshot.data![index].harga,
                desing: snapshot.data![index].nomer,
                desc: snapshot.data![index].desc,
                gambar: snapshot.data![index].gambar,
              );
            },
          );
        }
      },
    );
  }
}

//Mohamad Ilham Ramadhani - A11.2022.14587