import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class FlutterStripeIntegration extends StatefulWidget {
  const FlutterStripeIntegration({super.key});

  @override
  State<FlutterStripeIntegration> createState() =>
      _FlutterStripeIntegrationState();
}

class _FlutterStripeIntegrationState extends State<FlutterStripeIntegration> {
  Map<String, dynamic>? paymentIntent;

  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "USD", testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        style: ThemeMode.light,
        merchantDisplayName: "Ali",
        googlePay: gpay,
      ));
      displayPaymentSheet();
    } catch (e) {
      print("Error: $e");
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print("Error: $e");
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {
        "amount": "100",
        "currency": "USD",
      };
      http.Response response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51ORvfgKVlAPqjgHvpozlQ2VGiD4gRUgrurMTMOShea1x6Nu1Aa6zE7NlwaHHhs6CI9Kw1rFc0nAlldE8o07jOTdp00LM1DwF6e",
            "Content-Type": "application/x-www-form-urlencoded",
          });

      return json.decode(response.body);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: InkWell(
            onTap: () {
              makePayment();
              print("Payment hitted");
            },
            child: Container(
              width: 200,
              height: 60,
              color: Colors.blue,
              child: Center(child: Text("Payment")),
            ),
          ),
        ),
      ),
    );
  }
}
