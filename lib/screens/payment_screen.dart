import 'package:flutter/material.dart';

import '../services/payment_service.dart';

class PaymentDemoScreen extends StatefulWidget {
  const PaymentDemoScreen({super.key});

  @override
  State<PaymentDemoScreen> createState() => _PaymentDemoScreenState();
}

class _PaymentDemoScreenState extends State<PaymentDemoScreen> {
  final service = PaymentService();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final paymentService = PaymentService();
    return Scaffold(
      appBar: AppBar(title: const Text('Stripe Demo')),

      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await paymentService.makePayment(amount: '100');

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment Successful')),
                );

              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }
          },

          child: const Text('Pay \$100'),
        ),
      ),
    );
  }
}
