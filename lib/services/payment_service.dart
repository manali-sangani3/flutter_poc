import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  Map<String, dynamic>? _paymentIntent;

  Future<void> makePayment({
    required String amount,
    String currency = 'USD',
  }) async {
    try {
      // STEP 1: Create Payment Intent
      _paymentIntent = await _createPaymentIntent(amount, currency);

      // STEP 2: Initialize Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: _paymentIntent!['client_secret'],

          merchantDisplayName: 'Flutter POC Store',

          style: ThemeMode.system,
        ),
      );

      // STEP 3: Show Payment Sheet
      await _displayPaymentSheet();
    } catch (e) {
      debugPrint('Payment Error: $e');

      rethrow;
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      final body = {'amount': _calculateAmount(amount), 'currency': currency};

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),

        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',

          'Content-Type': 'application/x-www-form-urlencoded',
        },

        body: body,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create Payment Intent\n${response.body}');
      }

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Create Payment Intent Failed: $e');
    }
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      debugPrint('Payment Successful');

      _paymentIntent = null;
    } on StripeException catch (e) {
      debugPrint('Stripe Exception: $e');

      throw Exception('Payment Cancelled');
    } catch (e) {
      throw Exception('Payment Failed: $e');
    }
  }

  String _calculateAmount(String amount) {
    final calculatedAmount = int.parse(amount) * 100;

    return calculatedAmount.toString();
  }
}
