import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:device_info_plus/device_info_plus.dart';

class InAppPurchasePage extends StatefulWidget {
  const InAppPurchasePage({Key? key}) : super(key: key);

  @override
  State<InAppPurchasePage> createState() => _InAppPurchasePageState();
}

class _InAppPurchasePageState extends State<InAppPurchasePage> {
  late StreamSubscription? _purchaseUpdatedSubscription;
  late StreamSubscription? _purchaseErrorSubscription;
  late StreamSubscription? _conectionSubscription;
  final List<String> productLists = Platform.isAndroid
      ? [
          'android.test.purchased',
          'point_1000',
          // '5000_point',
          // 'android.test.canceled',
        ]
      : ['com.cooni.point1000', 'com.cooni.point5000'];

  String platformVersion = 'Unknown';
  List<IAPItem> items = [];
  List<PurchasedItem> purchases = [];
  Color cardColor = Colors.grey;

  bool isPaymentSuccess = false;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription!.cancel();
      _conectionSubscription = null;
    }
    super.dispose();
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.

    // prepare
    var result = await FlutterInappPurchase.instance.initialize();
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      setState(() {
        platformVersion = "Android $release";
      });
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var version = iosInfo.systemVersion;
      setState(() {
        platformVersion = "iOS $version";
      });
    }
    try {
      String msg = await FlutterInappPurchase.instance.consumeAll();
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription = FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      _getPurchases();
      print('purchase-updated: $productItem');
    });

    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
    _getPurchases();
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId!);
  }

  Future _getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getProducts(productLists);
    for (var item in items) {
      print(item.toString());
      this.items.add(item);
    }

    setState(() {
      this.items = items;
      purchases = [];
    });
  }

  Future _getPurchases() async {
    List<PurchasedItem>? items = await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items!) {
      print(item.toString());
      purchases.add(item);
    }
    purchases = items;

    if (purchases.length > 0) {
      cardColor = Colors.green.shade300;
      isPaymentSuccess = true;
      setState(() {});
    }
  }

  Future _getPurchaseHistory() async {
    List<PurchasedItem>? items = await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items!) {
      print(item.toString());
      purchases.add(item);
    }

    setState(() {
      this.items = [];
      purchases = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 200;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "In App Purchase",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        alignment: Alignment.center,
        height: 710,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Running on: $platformVersion\n',
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: buttonWidth,
                  height: 60.0,
                  margin: const EdgeInsets.all(7.0),
                  child: ElevatedButton(
                    onPressed: () {
                      print("---------- Get Items Button Pressed");
                      _getProduct();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: const Alignment(0.0, 0.0),
                      child: const Text(
                        'Get Items',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 370,
              child: Column(
                children: [
                  _renderInApps(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderInApps() {
    Widget widgets = (items.isNotEmpty) ? Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              "Product Id : ${items.first.productId}\nPrice : ${items.first.localizedPrice}\nTitle : ${items.first.title}\nCurrency : ${items.first.currency}\nDescription :${items.first.description}",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print("---------- Buy Item Button Pressed");
              _requestPurchase(items.first);
            },
            child: Container(
              width: 300,
              height: 40,
              alignment: Alignment.center,
              child: const Text('Buy Item'),
            ),
          ),
        ],
      ),
    ) : Container();
    return widgets;
  }

  Widget _renderPurchases() {
    Widget widgets = Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 5.0),
            child: Text(
              items.toString(),
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
    return widgets;
  }
}
