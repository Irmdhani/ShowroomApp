import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/landingPage.dart'; // Ganti dengan nama file home screen Anda

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Aplikasi Jual Beli Mobil'),
        backgroundColor: Color.fromRGBO(225, 176, 29, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Username',
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
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.amber),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black26,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
    );
  }

  _login() async {
    // Proses autentikasi
    // Contoh sederhana, bisa disesuaikan dengan backend atau metode autentikasi yang Anda gunakan
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'user' && password == 'password') {
      // Simpan informasi login menggunakan Shared Preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);

      // Pindah ke halaman home setelah login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      // Tampilkan pesan kesalahan jika login gagal
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Gagal'),
            content: Text('Username atau Password salah'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

//Mohamad Ilham Ramadhani - A11.2022.14587
