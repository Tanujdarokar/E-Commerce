import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:k_vinaya_ecommerce/providers.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final String totalAmount;
  const PaymentScreen({super.key, required this.totalAmount});

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  String selectedMethod = "UPI App";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Methods"),
        backgroundColor: const Color(0xFFE67E22),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            color: Colors.orange.shade50,
            child: Column(
              children: [
                const Text(
                  "Amount to Pay",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  "₹${widget.totalAmount}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD35400),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Payment Option",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildExpandableSection(
                  title: "UPI",
                  icon: Icons.account_balance_wallet,
                  options: ["UPI App", "upi Id", "upi Qr"],
                ),
                _buildExpandableSection(
                  title: "Cards",
                  icon: Icons.credit_card,
                  options: [
                    "Debit card",
                    "Atm card",
                    "Credit card",
                    "other card",
                  ],
                ),
                _buildPaymentTile(
                  "VKS Wallet",
                  Icons.wallet,
                  "Pay using Wallet balance",
                ),
                _buildPaymentTile(
                  "Cash on delivery",
                  Icons.wallet,
                  "Pay as per delivery",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD35400),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _processPayment();
              },
              child: Text(
                "PAY ₹${widget.totalAmount} NOW",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required IconData icon,
    required List<String> options,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: const Color(0xFFE67E22)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: options
            .map(
              (option) => RadioListTile(
                value: option,
                groupValue: selectedMethod,
                activeColor: const Color(0xFFD35400),
                title: Text(option),
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value.toString();
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPaymentTile(String title, IconData icon, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: selectedMethod == title
              ? const Color(0xFFE67E22)
              : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
        color: selectedMethod == title ? Colors.orange.shade50 : Colors.white,
      ),
      child: RadioListTile(
        value: title,
        groupValue: selectedMethod,
        activeColor: const Color(0xFFD35400),
        onChanged: (value) {
          setState(() {
            selectedMethod = value.toString();
          });
        },
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        secondary: Icon(icon, color: const Color(0xFFE67E22)),
      ),
    );
  }

  void _processPayment() {
    final cartItems = ref.read(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final ordersNotifier = ref.read(ordersProvider.notifier);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(now);
    String day = DateFormat('EEEE').format(now);

    DateTime deliveryStart = now.add(const Duration(hours: 2));
    DateTime deliveryEnd = now.add(const Duration(hours: 3));
    String deliveryTimeRange =
        "${DateFormat('hh:mm a').format(deliveryStart)} - ${DateFormat('hh:mm a').format(deliveryEnd)}";
    String deliveryDate = DateFormat('dd MMM yyyy').format(deliveryStart);
    String deliveryDay = DateFormat('EEEE').format(deliveryStart);

    Map<String, dynamic> newOrder = {
      'totalPrice': widget.totalAmount,
      'date': formattedDate,
      'day': day,
      'deliveryTime': deliveryTimeRange,
      'deliveryDate': deliveryDate,
      'deliveryDay': deliveryDay,
      'label': "Self Service",
      'status': "Complete",
      'image': cartItems.isNotEmpty ? cartItems[0]['image'] : '',
    };

    ordersNotifier.addOrder(newOrder);
    cartNotifier.clearCart();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        title: const Text("Order Successful"),
        content: Text("Your payment of ₹${widget.totalAmount} was successful."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text("Back to Home"),
          ),
        ],
      ),
    );
  }
}
