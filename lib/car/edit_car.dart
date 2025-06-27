// lib/car/edit_car.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uas/car/car.dart';
import 'package:uas/databases/databaseHelper.dart';

class EditCarPage extends StatefulWidget {
  final Car car;
  const EditCarPage({Key? key, required this.car}) : super(key: key);

  @override
  _EditCarPageState createState() => _EditCarPageState();
}

class _EditCarPageState extends State<EditCarPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _judulController;
  late TextEditingController _hargaController;
  late TextEditingController _nomerController;
  late TextEditingController _descController;
  
  List<Uint8List> _imageBytesList = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController(text: widget.car.judul);
    _hargaController = TextEditingController(text: widget.car.harga);
    _nomerController = TextEditingController(text: widget.car.nomer);
    _descController = TextEditingController(text: widget.car.desc);

    for (var base64Str in widget.car.gambar) {
      if (base64Str.isNotEmpty) {
        _imageBytesList.add(base64Decode(base64Str));
      }
    }
  }

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage(imageQuality: 70, maxWidth: 800);
    if (pickedFiles.isNotEmpty) {
      _imageBytesList.clear();
      for (var file in pickedFiles) {
        _imageBytesList.add(await file.readAsBytes());
      }
      setState(() {});
    }
  }

  Future<void> _updateCar() async {
    if (_formKey.currentState!.validate()) {
      if (_imageBytesList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mobil harus memiliki minimal satu gambar.')));
        return;
      }
      
      List<String> base64Images = _imageBytesList.map((bytes) => base64Encode(bytes)).toList();

      final updatedCar = Car(
        id: widget.car.id,
        judul: _judulController.text,
        harga: _hargaController.text,
        nomer: _nomerController.text,
        desc: _descController.text,
        gambar: base64Images,
      );

      await DatabaseHelper().updateCar(updatedCar);
      
      if (!mounted) return;
      Navigator.of(context).pop(true);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit ${widget.car.judul}')),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImagePicker(),
              SizedBox(height: 20),
              _buildTextFormField(controller: _judulController, label: 'Judul / Nama Mobil', icon: Icons.label_important_outline),
              SizedBox(height: 15),
              _buildTextFormField(controller: _hargaController, label: 'Harga', icon: Icons.attach_money, keyboardType: TextInputType.number),
              SizedBox(height: 15),
              _buildTextFormField(controller: _nomerController, label: 'Nomor Telepon', icon: Icons.phone_outlined, keyboardType: TextInputType.phone),
              SizedBox(height: 15),
              _buildTextFormField(controller: _descController, label: 'Deskripsi', icon: Icons.description_outlined, maxLines: 4),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _updateCar,
                icon: Icon(Icons.save_as_outlined),
                label: Text('Update Data'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
        Text("Foto Mobil", style: TextStyle(color: Colors.grey[700], fontSize: 16)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            height: 120, width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[400]!)),
            child: _imageBytesList.isNotEmpty
              ? GridView.builder(padding: EdgeInsets.all(8), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: _imageBytesList.length, itemBuilder: (context, index) => ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.memory(_imageBytesList[index], width: 100, height: 100, fit: BoxFit.cover)))
              : Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt_outlined, size: 40, color: Colors.grey[600]), SizedBox(height: 8), Text('Ketuk untuk ganti gambar', style: TextStyle(color: Colors.grey[600]))])),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField({required TextEditingController controller, required String label, required IconData icon, int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller, maxLines: maxLines, keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label, prefixIcon: Icon(icon, color: Colors.blueGrey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.blueGrey[800]!, width: 2)),
        filled: true, fillColor: Colors.white,
      ),
      validator: (value) => (value == null || value.isEmpty) ? '$label tidak boleh kosong' : null,
    );
  }
}