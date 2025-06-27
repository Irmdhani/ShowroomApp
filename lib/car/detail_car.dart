import 'package:flutter/material.dart';
import 'package:uas/landingPage.dart';

class DetailPage extends StatelessWidget {
  final String judul;
  final String harga;
  final String desing;
  final String desc;
  final String gambar;
  const DetailPage({
    super.key,
    required this.judul,
    required this.harga,
    required this.desing,
    required this.desc,
    required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.network(
                gambar,
                scale: 0.1,
              )),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(2),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 137, 137, 137),
              border: Border.all(
                width: 4,
                color: Color.fromARGB(255, 201, 127, 58),
              ),
            ),
            child: Column(children: [
              Text(
                judul,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                harga,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 156, 38, 38),
                ),
              ),
              Divider(
                thickness: 4,
                color: Color.fromARGB(190, 225, 201, 61),
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                desing,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 148, 66),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
                child: Text(
                  'Kembali',
                  style: TextStyle(color: Colors.amber),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

//Mohamad Ilham Ramadhani - A11.2022.14587