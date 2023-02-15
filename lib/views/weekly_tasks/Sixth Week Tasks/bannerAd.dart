import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../helpers/ads/google_ad_mob_helper.dart';

class BannerAdPage extends StatefulWidget {
  const BannerAdPage({Key? key}) : super(key: key);

  @override
  State<BannerAdPage> createState() => _BannerAdPageState();
}

class _BannerAdPageState extends State<BannerAdPage> {
  BannerAd? myBanner;

  bannerAd() {
    print("====================================");
    print("banner AD called");
    print("====================================");
    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          myBanner = ad as BannerAd?;
        });
      }),
    );
    myBanner!.load().then((value) => setState(() {}));
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bannerAd();
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (myBanner == null)
        ? const Text(
            "Banner Ad Not Loaded",
            style: TextStyle(color: Colors.white),
          )
        : SizedBox(
            width: myBanner!.size.width.toDouble(),
            height: myBanner!.size.height.toDouble(),
            child: AdWidget(
              // key: UniqueKey(),
              ad: myBanner!,
            ),
          );
  }
}
