import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: const Color(0xFFE67E22),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header Illustration or Icon
            const Icon(
              Icons.support_agent,
              size: 80,
              color: Color(0xFFE67E22),
            ),
            const SizedBox(height: 10),
            const Text(
              "How can we help you?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                "Our team is available to assist you with your orders and queries.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),

            // Support Options
            _buildSupportTile(
              icon: Icons.chat_outlined,
              title: "Chat with Us",
              subtitle: "Talk to our support team on WhatsApp",
              onTap: () {
                // Logic to open WhatsApp
              },
            ),
            _buildSupportTile(
              icon: Icons.email_outlined,
              title: "Email Support",
              subtitle: "support@vinayakakirana.com",
              onTap: () {
                // Logic to open Email client
              },
            ),
            _buildSupportTile(
              icon: Icons.question_answer_outlined,
              title: "FAQs",
              subtitle: "Common questions and answers",
              onTap: () {
                // Logic to navigate to FAQ page
              },
            ),
            _buildSupportTile(
              icon: Icons.call_outlined,
              title: "Call Us",
              subtitle: "+91 98765 43210",
              onTap: () {
                // Logic to open phone dialer
              },
            ),

            const SizedBox(height: 40),
            const Divider(),
            const Text(
              "App Version 1.0.0",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE67E22).withOpacity(0.1),
          child: Icon(icon, color: const Color(0xFFE67E22)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}