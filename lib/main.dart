import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe_integration/Payment_Integration_Stripe/stripe_integration.dart';

void main() async {
  Stripe.publishableKey =
      "pk_test_51ORvfgKVlAPqjgHvE74plrx6X8tL9OaqUEntKfZiS7hCzFn69emue1lvR4S7qS3bvcEpi2KvwLWpVX4STcxlsgBr007E76FbyK";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FlutterStripeIntegration(),
    );
  }
}
