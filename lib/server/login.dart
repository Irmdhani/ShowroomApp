// lib/server/login.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/landingPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[800]!, Colors.blueGrey[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Login to continue',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(height: 50),
                _buildTextField(
                    controller: _usernameController,
                    hintText: 'Username',
                    icon: Icons.person_outline),
                SizedBox(height: 20),
                _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: true),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      required IconData icon,
      bool obscureText = false}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.blueGrey),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
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

