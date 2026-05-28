import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: const Color(0xFFE67E22),
      ),
      body: ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFE67E22).withOpacity(0.1),
              child: const Icon(Icons.notifications_active, color: Color(0xFFE67E22)),
            ),
            title: Text("Order Update #${100 + index}"),
            subtitle: const Text("Your order has been packed and is ready for delivery."),
            trailing: const Text("2h ago", style: TextStyle(fontSize: 12, color: Colors.grey)),
            onTap: () {}, // Mark as read
          );
        },
      ),
    );
  }
}