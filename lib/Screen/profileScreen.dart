import 'package:flutter/material.dart';
import 'package:k_vinaya_ecommerce/Auth/loginScreen.dart';
import 'package:k_vinaya_ecommerce/Screen/editScreen.dart';
import 'package:k_vinaya_ecommerce/Screen/settingScreen.dart';
import 'package:k_vinaya_ecommerce/Screen/supportScreen.dart';

class ProfileOptionsScreen extends StatelessWidget {
  const ProfileOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        backgroundColor: const Color(0xFFE67E22),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centers content horizontally
        children: [
          const SizedBox(height: 30),
          // Center the Profile Section
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFE67E22),
                  child: Icon(Icons.person, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Vinayaka User", // Dynamic Username
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "user@email.com", // Dynamic Email
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Menu Options
          _buildProfileTile(
            icon: Icons.edit,
            title: "Edit Profile",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfileScreen()),
            ),
          ),
          _buildProfileTile(
            icon: Icons.settings,
            title: "Settings",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            ),
          ),
          _buildProfileTile(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupportScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color == Colors.red ? Colors.red : const Color(0xFFE67E22),
      ),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
