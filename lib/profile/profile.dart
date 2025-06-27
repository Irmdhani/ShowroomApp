import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas/server/login.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        children: [
          _buildProfileHeader(),
          SizedBox(height: 20),
          _buildProfileOption(
            icon: Icons.edit_outlined,
            title: 'Edit Profile',
            subtitle: 'Ubah data diri Anda',
            onTap: () {},
          ),
          _buildProfileOption(
            icon: Icons.history,
            title: 'Riwayat Transaksi',
            subtitle: 'Lihat semua penjualan dan pembelian',
            onTap: () {},
          ),
          _buildProfileOption(
            icon: Icons.settings_outlined,
            title: 'Pengaturan',
            subtitle: 'Atur preferensi aplikasi',
            onTap: () {},
          ),
          Divider(height: 40, indent: 20, endIndent: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.jpeg'),
          ),
          SizedBox(height: 10),
          Text(
            'Mohamad Ilham Ramadhani', // Ganti dengan nama pengguna
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'A11.2022.14587', // Ganti dengan info lain
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueGrey),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
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