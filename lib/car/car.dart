class Car {
  int? id;
  String judul;
  String harga;
  String nomer;
  String desc;
  String gambar;

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
      'gambar': gambar,
    };
  }
}

//Mohamad Ilham Ramadhani - A11.2022.14587