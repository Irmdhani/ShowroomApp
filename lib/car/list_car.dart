import 'package:flutter/material.dart';
import 'package:uas/car/detail_car.dart';

class ListItem extends StatelessWidget {
  final String judul;
  final String harga;
  final String desing;
  final String desc;
  final String gambar;

  const ListItem({
    Key? key,
    required this.judul,
    required this.harga,
    required this.desing,
    required this.desc,
    required this.gambar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      judul: judul,
                      harga: harga,
                      desing: desing,
                      desc: desc,
                      gambar: gambar,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 201, 127, 58),
            borderRadius: BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 139, 97, 41),
                offset: Offset(3.0, 5.0),
                blurRadius: 2.0,
              ),
            ]),
        height: 110,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              gambar,
              width: 75,
              height: 75,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  harga,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 106, 23, 23),
                  ),
                ),
                Text(
                  desing,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(28, 156, 17, 1),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//Mohamad Ilham Ramadhani - A11.2022.14587