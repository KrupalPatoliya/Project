import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:training_app/helpers/ads/google_ad_mob_helper.dart';
import 'package:training_app/views/weekly_tasks/Sixth%20Week%20Tasks/bannerAd.dart';
import 'package:training_app/views/weekly_tasks/Sixth%20Week%20Tasks/native_medium_ad_page.dart';
import 'package:training_app/views/weekly_tasks/Sixth%20Week%20Tasks/nativeadd.dart';
import 'package:training_app/views/weekly_tasks/Sixth%20Week%20Tasks/videoAdNative.dart';

class AdMobPage extends StatefulWidget {
  const AdMobPage({Key? key}) : super(key: key);

  @override
  State<AdMobPage> createState() => _AdMobPageState();
}

class _AdMobPageState extends State<AdMobPage> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AdMob.adMob.interstitial();
      AdMob.adMob.interstitialVideo();
      AdMob.adMob.rewardAd();
      AdMob.adMob.rewardInterstitialAd();
    });
    super.initState();
  }

  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "AD Mob",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Colors.white,
              ),
              const Text(
                "Banner Ad",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Colors.white,
              ),
              const BannerAdPage(),
              const Divider(
                color: Colors.white,
              ),
              const Text(
                "Interstitial Ad",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Colors.white,
              ),
              GestureDetector(
                onTap: () {
                  if (AdMob.adMob.interstitialAd == null) {
                    AdMob.adMob.interstitial();
                    AdMob.adMob.interstitialAd!.show();
                  } else {
                    AdMob.adMob.interstitialAd!.show();
                    AdMob.adMob.interstitial();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Interstitial Ads",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (AdMob.adMob.interstitialVideoAd == null) {
                    AdMob.adMob.interstitialVideo();
                    AdMob.adMob.interstitialVideoAd!.show();
                  } else {
                    AdMob.adMob.interstitialVideoAd!.show();
                    AdMob.adMob.interstitialVideo();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "InterstitialVideo Ads",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              const Text(
                "Reward Ad",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Colors.white,
              ),
              GestureDetector(
                onTap: () {
                  if (AdMob.adMob.rewardedAd == null) {
                    AdMob.adMob.rewardAd();
                    AdMob.adMob.rewardedAd!.show(
                      onUserEarnedReward: (ad, reward) {},
                    );
                  } else {
                    AdMob.adMob.rewardedAd!.show(
                      onUserEarnedReward: (ad, reward) {},
                    );
                    AdMob.adMob.rewardAd();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Reward Ads",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (AdMob.adMob.rewardedInterstitialAd == null) {
                    AdMob.adMob.rewardInterstitialAd();
                    AdMob.adMob.rewardedInterstitialAd!.show(
                      onUserEarnedReward: (ad, reward) {},
                    );
                  } else {
                    AdMob.adMob.rewardedInterstitialAd!.show(
                      onUserEarnedReward: (ad, reward) {},
                    );
                    AdMob.adMob.rewardInterstitialAd();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Reward interstitial Ads",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              const Text(
                "Native Ads",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Colors.white,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NativeAdd(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Native Banner Small Ads",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NativeMediumBannerAdPage(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Native Banner Medium Ads",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const NativeVideoAd(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              //     height: 50,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       color: Colors.blue,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Text(
              //       "Native Video Ads",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              // (AdMob.adMob.myNativeVideo == null)
              //     ? const Text(
              //         "Banner Ad Not Loaded",
              //         style: TextStyle(color: Colors.white),
              //       )
              //     : Container(
              //         alignment: Alignment.center,
              //         // color: Colors.white;
              //         height: 600,
              //         child: AdWidget(
              //           ad: AdMob.adMob.myNativeVideo!..load().then((value) => setState((){})),
              //         ),
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
