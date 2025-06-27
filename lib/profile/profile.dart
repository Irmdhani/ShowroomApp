import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/server/login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 220, 129),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.jpeg'),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: const Text('Profile'),
            subtitle: Text('Edit Profile'),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: const Text('Order'),
            subtitle: Text('Detail Pembelian dan Penjualan Anda'),
            leading: Icon(Icons.card_giftcard),
          ),
          ListTile(
            title: const Text('Options'),
            subtitle: Text('Pengaturan'),
            leading: Icon(Icons.settings),
          ),
          ElevatedButton(
            onPressed: () {
              _logout(context);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.amber),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}

_logout(BuildContext context) async {
  // Hapus informasi login dari Shared Preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('username');

  // Pindah kembali ke halaman login setelah logout
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}

//Mohamad Ilham Ramadhani - A11.2022.14587