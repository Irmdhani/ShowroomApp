// lib/car/car.dart
class Car {
  int? id;
  String judul;
  String harga;
  String nomer;
  String desc;
  List<String> gambar; // Diubah menjadi List<String>

  Car({
    this.id,
    required this.judul,
    required this.harga,
    required this.nomer,
    required this.desc,
    required this.gambar,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'harga': harga,
      'nomer': nomer,
      'desc': desc,
      'gambar': gambar.join('|||'), // Gabungkan dengan pemisah unik
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    String gambarString = map['gambar'] ?? '';
    return Car(
      id: map['id'],
      judul: map['judul'] ?? '',
      harga: map['harga'] ?? '',
      nomer: map['nomer'] ?? '',
      desc: map['desc'] ?? '',
      gambar: gambarString.isNotEmpty ? gambarString.split('|||') : [],
    );
  }
}