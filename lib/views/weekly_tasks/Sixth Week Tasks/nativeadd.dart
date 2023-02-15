import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../helpers/ads/google_ad_mob_helper.dart';

class NativeAdd extends StatefulWidget {
  const NativeAdd({Key? key}) : super(key: key);

  @override
  State<NativeAdd> createState() => _NativeAddState();
}

class _NativeAddState extends State<NativeAdd> {
  NativeAd? myNative;
  NativeAd? myNativeVideo;

  nativeAds() {
    //   const _adUnitIDNative = "ca-app-pub-3940256099942544/1044960115";
    //   myNativeVideo = NativeAd(
    //   adUnitId: _adUnitIDNative,
    //   factoryId: 'listTileVideo',
    //   request: const AdRequest(),
    //   listener: NativeAdListener(
    //     onAdLoaded: (Ad ad) {
    //       print('natty $NativeAd loaded.');
    //       print("====================================");
    //       print("ad Loaded");
    //       print("====================================");
    //       myNativeVideo = ad as NativeAd?;
    //     },
    //   ),
    // );

    const String adUnitIDNative = "ca-app-pub-3940256099942544/2247696110";
    myNative = NativeAd(
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      factoryId: "listTile",
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdFailedToLoad: (Ad, LoadAdError) {
          print("=================================================");
          print('Native $Ad loaded.');
          print('Native $LoadAdError loaded.');
          nativeAds();
          print("=================================================");
        },
        onAdLoaded: (Ad ad) {
          print('Native $NativeAd loaded.');
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nativeAds();
      // AdMob.adMob.myNative!.dispose();
      // AdMob.adMob.nativeAds();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AdMob.adMob.myNative!.dispose();
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
