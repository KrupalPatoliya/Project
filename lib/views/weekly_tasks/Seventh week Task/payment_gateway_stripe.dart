// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:training_app/views/weekly_tasks/widgets/custombutton.dart';

class PaymentGateWayStripePage extends StatefulWidget {
  const PaymentGateWayStripePage({Key? key}) : super(key: key);

  @override
  State<PaymentGateWayStripePage> createState() => _PaymentGateWayStripePageState();
}

class _PaymentGateWayStripePageState extends State<PaymentGateWayStripePage> {
  Map<String, dynamic>? paymentIntent;
  TextEditingController controller = TextEditingController();
  String value = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Stripe Payment GateWay", style: TextStyle(color: Colors.white)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                controller: controller,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter your Amount...";
                  }
                  return null;
                },
                onSaved: (val) {
                  value = val!;
                },
                decoration: InputDecoration(
                  label: const Text(
                    "Amount",
                    style: TextStyle(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.white70,
                      width: 1.0,
                    ),
                  ),
                  hintStyle: const TextStyle(color: Colors.white),
                  hintText: "Enter your Amount here",
                  fillColor: Colors.white24,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.white70,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            customButton(
              name: 'Make Payment',
              tap: () async {
                value = controller.text;
                await makePayment();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(value, "INR");
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              setupIntentClientSecret: "sk_test_51MMn8eSDaDr46PdIjk6R0vPVMbFsHbGjJXDUAKmeXqggS5aCJuLeX29NCSibZdQAGJxZIuPWWvjtlEzCMTj1POBR00BBhHhviQ",
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "IN", merchantCountryCode: "+91"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Krupali',
            ),
          )
          .then((value) {});

      ///now finally display payment sheet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled..."),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
        "description": "Test Method",
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51MMn8eSDaDr46PdIjk6R0vPVMbFsHbGjJXDUAKmeXqggS5aCJuLeX29NCSibZdQAGJxZIuPWWvjtlEzCMTj1POBR00BBhHhviQ',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
