import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentGateWayPage extends StatefulWidget {
  const PaymentGateWayPage({Key? key}) : super(key: key);

  @override
  State<PaymentGateWayPage> createState() => _PaymentGateWayPageState();
}

class _PaymentGateWayPageState extends State<PaymentGateWayPage> {
  Razorpay razorpay = Razorpay();

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_NNbwJ9tmM0fbxj',
      'amount': 39900,
      'name': 'Krupali',
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void listerOfRazorPay() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('msg: "SUCCESS: ${response.paymentId}", timeInSecForIos: 4');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(' msg: "ERROR: ${response.code} - ${response.message}",timeInSecForIos: 4');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('msg: "EXTERNAL_WALLET: ${response.walletName}", timeInSecForIos: 4');
  }

  @override
  void initState() {
    // TODO: implement initState
    // openCheckout();
    listerOfRazorPay();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Payment GateWay", style: TextStyle(color: Colors.white)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 260,
              width: 500,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3, color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Green Tea",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: CachedNetworkImageProvider(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk5_BoqBXQsOl4GCkkJy8fYPxC_r82lIzKgQ&usqp=CAU",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width : 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Lipton Lemon Zest Green\nTea Bags 25's",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Rejuvenate your senses with\nrefreshing green tea.Straight from\nthe foothills of the Nilgiris.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "300gms for ₹399 only!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          openCheckout();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
                          child: Text(
                            "Check Out !",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
