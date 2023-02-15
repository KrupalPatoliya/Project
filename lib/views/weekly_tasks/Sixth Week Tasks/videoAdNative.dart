import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeVideoAd extends StatefulWidget {
  const NativeVideoAd({Key? key}) : super(key: key);

  @override
  State<NativeVideoAd> createState() => _NativeVideoAdState();
}

class _NativeVideoAdState extends State<NativeVideoAd> {
  NativeAd? myNative;

  nativeAds() {
    myNative = NativeAd(
      adUnitId: "ca-app-pub-3940256099942544/1044960115",
      factoryId: "listTileVideo",
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdFailedToLoad: (ad, loadAdError) {
          nativeAds();
        },
        onAdLoaded: (Ad ad) {
          setState(() {
            myNative = ad as NativeAd?;
          });
        },
      ),
    );
    myNative!.load();
  }

  @override
  void initState() {
    // TODO: implement initState
    nativeAds();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myNative!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Native Ad",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: (myNative == null)
          ? const Center(
              child: Text(
                "Banner Ad Not Loaded",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          : Center(
              child: Container(
                // color: Colors.white,
                height: 200,
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                alignment: Alignment.center,
                // height: 600,
                child: AdWidget(
                  key: UniqueKey(),
                  ad: myNative!,
                ),
              ),
            ),
    );
  }
}
