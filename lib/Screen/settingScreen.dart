import 'package:flutter/material.dart';
import 'package:k_vinaya_ecommerce/globals.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900]
            : const Color(0xFFE67E22),
      ),
      body: ListView(
        children: [
          // Theme Toggle Section
          ValueListenableBuilder<ThemeMode>(
            valueListenable: globalThemeMode,
            builder: (context, currentMode, child) {
              final isDark = currentMode == ThemeMode.dark;
              return SwitchListTile(
                title: const Text(
                  "Dark Mode",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(isDark ? "Dark theme enabled" : "Light theme enabled"),
                secondary: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  color: isDark ? Colors.amber : Colors.blue,
                ),
                value: isDark,
                activeThumbColor: const Color(0xFFE67E22),
                onChanged: (bool value) {
                  globalThemeMode.value = value ? ThemeMode.dark : ThemeMode.light;
                },
              );
            },
          ),
          
          const Divider(),
          
          SwitchListTile(
            title: const Text("Push Notifications"),
            subtitle: const Text("Get updates on your orders"),
            value: true,
            activeThumbColor: const Color(0xFFE67E22),
            onChanged: (bool value) {},
          ),
          
          const Divider(),
          
          _buildSettingsTile(
            context,
            title: "Change Password",
            icon: Icons.lock_outline,
            onTap: () {},
          ),
          _buildSettingsTile(
            context,
            title: "Language",
            icon: Icons.language,
            subtitle: "English",
            onTap: () {},
          ),
          _buildSettingsTile(
            context,
            title: "Privacy Policy",
            icon: Icons.privacy_tip_outlined,
            onTap: () {},
          ),
          _buildSettingsTile(
            context,
            title: "About App",
            icon: Icons.info_outline,
            onTap: () {},
          ),
          
          const SizedBox(height: 20),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {},
              child: const Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
