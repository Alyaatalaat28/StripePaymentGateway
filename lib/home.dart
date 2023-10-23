
import 'package:flutter/material.dart';
import 'package:stripe_payment_gateway/stripePayments/payment_manager.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            PaymentManager.paymentManager(40,'EGP' );
          },
           child: const Text('Pay',)),
      ),
    );
  }
}