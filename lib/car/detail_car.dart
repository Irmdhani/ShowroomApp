// lib/car/detail_car.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:uas/car/car.dart';
import 'package:uas/car/edit_car.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uas/databases/databaseHelper.dart'; 

class DetailPage extends StatelessWidget {
  final Car car;
  const DetailPage({Key? key, required this.car}) : super(key: key);

  // Fungsi untuk memformat harga
  String _formatHarga(String harga) {
    try {
      final number = int.parse(harga.replaceAll(RegExp(r'[^0-9]'), ''));
      final RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      
      // --- PERBAIKAN DI SINI ---
      // Deklarasikan tipe fungsi secara eksplisit dan benar
      final String Function(Match) mathFunc = (Match match) => '${match[1]}.';
      
      return 'Rp ' + number.toString().replaceAllMapped(regExp, mathFunc);
    } catch (e) {
      return harga; // Kembalikan harga asli jika format gagal
    }
  }

  // Fungsi untuk menghubungi penjual via WhatsApp
  Future<void> _hubungiPenjual(BuildContext context) async {
    String nomorWhatsapp = car.nomer.replaceAll(RegExp(r'[^0-9]'), '');
    if (nomorWhatsapp.startsWith('0')) {
      nomorWhatsapp = '62' + nomorWhatsapp.substring(1);
    } else if (!nomorWhatsapp.startsWith('62')) {
      nomorWhatsapp = '62' + nomorWhatsapp;
    }
    
    final Uri whatsappUrl = Uri.parse('https://wa.me/$nomorWhatsapp?text=Halo, saya tertarik dengan mobil ${car.judul}.');
    
    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak bisa membuka WhatsApp. Pastikan aplikasi terinstall.')),
      );
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('Hapus Mobil'),
          content: Text('Apakah Anda yakin ingin menghapus "${car.judul}"?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Batal')),
            TextButton(
              onPressed: () async {
                await DatabaseHelper().deleteCar(car.id!);
                Navigator.of(ctx).pop(); 
                Navigator.of(context).pop(true);
              },
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(car.judul),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            style: IconButton.styleFrom(
              foregroundColor: Colors.white, 
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditCarPage(car: car)),
              );
              if (result == true) {
                Navigator.of(context).pop(true);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            style: IconButton.styleFrom(
              foregroundColor: Colors.red, 
            ),
            onPressed: () => _showDeleteConfirmation(context),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _hubungiPenjual(context),
        backgroundColor: Colors.green[600],
        icon: Icon(Icons.chat_bubble_outline, color: Colors.white),
        label: Text("Hubungi Penjual", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (car.gambar.isNotEmpty && car.gambar.first.isNotEmpty)
              Container(
                height: 250,
                color: Colors.black,
                child: PageView.builder(
                  itemCount: car.gambar.length,
                  itemBuilder: (context, index) {
                    try {
                      Uint8List bytes = base64Decode(car.gambar[index]);
                      return Image.memory(bytes, fit: BoxFit.contain);
                    } catch (e) {
                      return Icon(Icons.broken_image, size: 150, color: Colors.grey);
                    }
                  },
                ),
              )
            else
              Container(height: 250, color: Colors.grey[300], child: Center(child: Icon(Icons.camera_alt, size: 80, color: Colors.grey[600]))),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatHarga(car.harga),
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red[800]),
                  ),
                  SizedBox(height: 10),
                  Divider(height: 40, thickness: 1),
                  Text('Deskripsi', style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: 10),
                  Text(car.desc, textAlign: TextAlign.justify, style: TextStyle(fontSize: 16, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}