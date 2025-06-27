// lib/car/list_car.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:uas/car/car.dart';
import 'package:uas/car/detail_car.dart';

// Fungsi untuk memformat harga menjadi format Rupiah
String _formatHarga(String harga) {
  try {
    // Menghapus semua karakter non-numerik
    final number = int.parse(harga.replaceAll(RegExp(r'[^0-9]'), ''));
    // Regex untuk menambahkan titik sebagai pemisah ribuan
    final RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final String Function(Match) mathFunc = (Match match) => '${match[1]}.';
    return 'Rp ' + number.toString().replaceAllMapped(regExp, mathFunc);
  } catch (e) {
    // Jika harga tidak bisa di-parse, kembalikan teks aslinya
    return harga;
  }
}

// Widget untuk menampilkan gambar pertama dari list
Widget _buildCarImage(List<String> images) {
  // Cek jika list gambar kosong atau string gambar pertama kosong
  if (images.isEmpty || images.first.isEmpty) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[200],
      child: Icon(Icons.directions_car, size: 50, color: Colors.grey[400]),
    );
  }
  
  try {
    // Decode gambar pertama dari base64
    Uint8List bytes = base64Decode(images.first);
    return Image.memory(
      bytes,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  } catch (e) {
    // Fallback jika terjadi error saat decoding
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[200],
      child: Icon(Icons.broken_image, size: 50, color: Colors.grey[400]),
    );
  }
}

class ListItem extends StatelessWidget {
  final Car car;
  final VoidCallback onDataChanged;

  const ListItem({Key? key, required this.car, required this.onDataChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias, // Memastikan InkWell tidak keluar dari border radius
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPage(car: car)),
          );
          // Jika ada perubahan (edit/delete) dari halaman detail, refresh list
          if (result == true) {
            onDataChanged();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: _buildCarImage(car.gambar),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      car.judul,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    // --- PERUBAHAN DI SINI ---
                    Text(
                      _formatHarga(car.harga), // Terapkan fungsi format di sini
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Tidak menampilkan nomor telepon di list agar lebih ringkas
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}