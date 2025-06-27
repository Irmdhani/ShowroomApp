// lib/car/jual.dart

// 1. PASTIKAN SEMUA IMPORT ADA DI PALING ATAS
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uas/car/car.dart';
import 'package:uas/databases/databaseHelper.dart';

// 2. DEKLARASI CLASS DIMULAI SETELAH SEMUA IMPORT
class Jual extends StatefulWidget {
  @override
  _JualState createState() => _JualState();
}

class _JualState extends State<Jual> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _hargaController = TextEditingController();
  final _nomerController = TextEditingController();
  final _descController = TextEditingController();
  
  List<Uint8List> _imageBytesList = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(imageQuality: 70, maxWidth: 800);
    if (pickedFiles.isNotEmpty) {
      _imageBytesList.clear(); // Hapus gambar sebelumnya untuk diganti yang baru
      for (var file in pickedFiles) {
        _imageBytesList.add(await file.readAsBytes());
      }
      setState(() {});
    }
  }

  Future<void> _saveCar() async {
    if (_formKey.currentState!.validate()) {
      if (_imageBytesList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih minimal satu gambar.')));
        return;
      }

      List<String> base64Images = _imageBytesList.map((bytes) => base64Encode(bytes)).toList();
      final car = Car(
        judul: _judulController.text,
        harga: _hargaController.text,
        nomer: _nomerController.text,
        desc: _descController.text,
        gambar: base64Images,
      );

      await DatabaseHelper().insertCar(car);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mobil berhasil ditambahkan!'), backgroundColor: Colors.green));
      
      _formKey.currentState!.reset();
      setState(() { _imageBytesList.clear(); });
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _hargaController.dispose();
    _nomerController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Jual Mobil Anda', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey[800]), 
                textAlign: TextAlign.center
              ),
              SizedBox(height: 8),
              Text(
                'Unggah foto dan isi detail mobil.', 
                style: TextStyle(fontSize: 16, color: Colors.grey[600]), 
                textAlign: TextAlign.center
              ),
              SizedBox(height: 30),
              _buildImagePicker(),
              SizedBox(height: 20),
              _buildTextFormField(
                controller: _judulController, 
                label: 'Judul / Nama Mobil', 
                icon: Icons.label_important_outline
              ),
              SizedBox(height: 15),
              _buildTextFormField(
                controller: _hargaController, 
                label: 'Harga', 
                icon: Icons.attach_money, 
                keyboardType: TextInputType.number
              ),
              SizedBox(height: 15),
              _buildTextFormField(
                controller: _nomerController, 
                label: 'Nomor Telepon (WA)', 
                icon: Icons.phone_outlined, 
                keyboardType: TextInputType.phone
              ),
              SizedBox(height: 15),
              _buildTextFormField(
                controller: _descController, 
                label: 'Deskripsi', 
                icon: Icons.description_outlined, 
                maxLines: 4
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _saveCar,
                icon: Icon(Icons.add_circle_outline),
                label: Text('Tambahkan Mobil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[800], 
                  foregroundColor: Colors.white, 
                  padding: EdgeInsets.symmetric(vertical: 15), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), 
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Foto Mobil (wajib diisi)", style: TextStyle(color: Colors.grey[700], fontSize: 16)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200], 
              borderRadius: BorderRadius.circular(12), 
            ),
            child: _imageBytesList.isNotEmpty
              ? GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _imageBytesList.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(_imageBytesList[index], fit: BoxFit.cover),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Icon(Icons.camera_alt_outlined, size: 40, color: Colors.grey[600]), 
                      SizedBox(height: 8), 
                      Text('Ketuk untuk pilih gambar', style: TextStyle(color: Colors.grey[600]))
                    ]
                  )
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller, 
    required String label, 
    required IconData icon, 
    int maxLines = 1, 
    TextInputType keyboardType = TextInputType.text
  }) {
    return TextFormField(
      controller: controller, 
      maxLines: maxLines, 
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label, 
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.blueGrey[800]!, width: 2)),
        filled: true, 
        fillColor: Colors.white,
      ),
      validator: (value) => (value == null || value.isEmpty) ? '$label tidak boleh kosong' : null,
    );
  }
}