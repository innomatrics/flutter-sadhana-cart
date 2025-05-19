import 'package:flutter/material.dart';
import 'package:sadhana_cart/Customer/cancellation_faqs_questions.dart';
import 'package:sadhana_cart/Customer/faqs_list_screen.dart';
import 'package:sadhana_cart/Customer/grocery_faqs_questions.dart';
import 'package:sadhana_cart/Customer/login_faqs_questions.dart';
import 'package:sadhana_cart/Customer/payment_faqs_questions.dart';
import 'package:sadhana_cart/Customer/pickup_faqs_questions.dart';
import 'package:sadhana_cart/Customer/refund_faqs_questions.dart';
import 'package:sadhana_cart/Customer/return_faqs_questions.dart';
import 'package:sadhana_cart/Customer/two_wheeler_faqs_questions.dart';



class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sadhana Cart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'FAQs',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Help Topics',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildHelpOption(Icons.local_shipping, 'Delivery Related FAQs', context),
                  _buildHelpOption(Icons.login, 'Login Related FAQs', context),
                  _buildHelpOption(Icons.money_off, 'Refund Related FAQs', context),
                  _buildHelpOption(Icons.payment, 'Payment Related FAQs', context),
                  _buildHelpOption(Icons.assignment_return, 'Return Related FAQs', context),
                  _buildHelpOption(Icons.store, 'Pickup Related FAQs', context),
                  _buildHelpOption(Icons.cancel, 'Cancellation Related FAQs', context),
                  _buildHelpOption(Icons.shopping_basket, 'Grocery Related FAQs', context),
                  _buildHelpOption(Icons.two_wheeler, 'Two Wheeler Related FAQs', context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build each list item
  Widget _buildHelpOption(IconData icon, String title, BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(title, style: const TextStyle(fontSize: 15)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 15),
          onTap: () {
            // Navigate to respective pages based on the help topic
            if (title == 'Delivery Related FAQs') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQListPage()),
              );
            } else if (title == 'Login Related FAQs') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginFaqsQuestions()),
              );
            } else if (title == 'Refund Related FAQs') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RefundRelatedFaqs()),
              );
            } else if (title == 'Payment Related FAQs') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentFaqsQuestions()),
              );
            } else if (title == 'Return Related FAQs') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReturnFaqsQuestions()),
              );
            } else if (title == 'Pickup Related FAQs') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PickupFaqsQuestions()),
              );
            } else if (title == 'Cancellation Related FAQs') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CancellationFaqsQuestions()),
              );
            } else if (title == 'Grocery Related FAQs') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GroceryFaqsQuestions()),
              );
            } else if (title == 'Two Wheeler Related FAQs') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TwoWheelerFaqsQuestions()),
              );
            }
            // Add similar conditions for other pages
          },
        ),
        const Divider(),
      ],
    );
  }
}