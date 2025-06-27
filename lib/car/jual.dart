import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:uas/databases/databaseHelper.dart';
import 'package:uas/car/car.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _judulController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _nomerController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  File? _imageFile;

  Uint8List? _imageBytes;

  void _pickImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      setState(() {
        _imageFile = imageFile;
        _imageBytes = imageFile.readAsBytesSync();
      });
    }
  }

  TextEditingController _gambarController = TextEditingController();

  void tambahDataKeDatabase() async {
    // Jika gambar telah diunggah, lakukan pengunggahan gambar
    if (_imageFile != null) {
      // Implementasikan logika pengunggahan gambar ke server jika diperlukan
      // ...
      // Contoh: Simpan path gambar di dalam variabel gambar
      String imagePath = _imageFile!.path;
      _gambarController.text = imagePath;

      // Selanjutnya, simpan data ke database
      DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.insertCar(Car(
        id: 10,
        judul: _judulController.text,
        harga: _hargaController.text,
        nomer: _nomerController.text,
        desc: _descController.text,
        gambar: _gambarController.text,
      ));
      _judulController.clear();
      _hargaController.clear();
      _nomerController.clear();
      _descController.clear();
      _gambarController.clear();

      // Bersihkan juga _imageFile dan _imageBytes jika Anda menggunakannya
      setState(() {
        _imageFile = null;
        _imageBytes = null;
      });
    } else {
      // Jika gambar tidak diunggah, simpan data ke database langsung
      DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.insertCar(Car(
        id: 10,
        judul: _judulController.text,
        harga: _hargaController.text,
        nomer: _nomerController.text,
        desc: _descController.text,
        gambar: _gambarController.text,
      ));
      _judulController.clear();
      _hargaController.clear();
      _nomerController.clear();
      _descController.clear();
      _gambarController.clear();

      // Bersihkan juga _imageFile dan _imageBytes jika Anda menggunakannya
      setState(() {
        _imageFile = null;
        _imageBytes = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
        ),
        TextField(
          controller: _judulController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Nama Mobil',
            labelStyle:
                TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const Color.fromARGB(
                      255, 255, 255, 255)), // Warna border saat focus
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
        TextField(
          controller: _hargaController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Harga',
            labelStyle:
                TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: const Color.fromARGB(
                      255, 255, 255, 255)), // Warna border saat focus
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
        TextField(
          controller: _nomerController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'No WA',
              labelStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const Color.fromARGB(
                        255, 255, 255, 255)), // Warna border saat focus
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)),
        ),
        TextField(
          controller: _descController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: 'Deskripsi',
              labelStyle:
                  TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: const Color.fromARGB(
                        255, 255, 255, 255)), // Warna border saat focus
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)),
        ),
        Container(
          margin: EdgeInsets.only(top: 16.0),
          child: ElevatedButton(
            onPressed: _pickImage,
            child: Text(
              'Pilih Gambar',
              style: TextStyle(color: Colors.amber),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ),
        _imageBytes != null
            ? Image.memory(
                _imageBytes!,
                height: 100,
                width: 100,
              )
            : SizedBox(height: 0),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.only(top: 16.0),
          child: ElevatedButton(
            onPressed: () {
              tambahDataKeDatabase();
            },
            child: Text(
              'Tambah Data ke Database',
              style: TextStyle(color: Colors.amber),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black26),
          ),
        ),
        SizedBox(height: 16),
        FutureBuilder<List<Car>>(
          future: DatabaseHelper().getCars(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('Belum ada data di database.');
            } else {
              // Tampilkan data dari database (mungkin dalam bentuk ListView)
              return Text('Data berhasil ditambahkan ke database!');
            }
          },
        ),
      ],
    );
  }
}

//Mohamad Ilham Ramadhani - A11.2022.14587