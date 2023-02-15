import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:training_app/helpers/ads/facebook_ad_helpper.dart';

class FaceBookAdsPage extends StatefulWidget {
  const FaceBookAdsPage({Key? key}) : super(key: key);

  @override
  State<FaceBookAdsPage> createState() => _FaceBookAdsPageState();
}

class _FaceBookAdsPageState extends State<FaceBookAdsPage> {
/*  Widget currentAd = const SizedBox(
    width: 400,
    height: 60,
    child: Center(child: Text("Ad Loaded", style: TextStyle(color: Colors.white))),
  );

  banner() {
    setState(() {
      currentAd = FacebookBannerAd(
        placementId: "IMG_16_9_LINK#YOUR_PLACEMENT_ID",
        bannerSize: BannerSize.STANDARD,
        keepAlive: true,
        listener: (result, value) {
          switch (result) {
            case BannerAdResult.LOADED:
              print("=======================================");
              print("Loaded: $value");
              print("=======================================");
              break;
            case BannerAdResult.ERROR:
              print("=======================================");
              print("Error: $value");
              print("=======================================");
              break;
            case BannerAdResult.CLICKED:
              print("Clicked: $value");
              break;
            case BannerAdResult.LOGGING_IMPRESSION:
              print("Logging Impression: $value");
              break;
          }
        },
      );
    });
  }*/

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // FacebookAudienceNetwork.init();
      FacebookAudienceNetwork.init(
          testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
          iOSAdvertiserTrackingEnabled: true //default false
          );
      // banner();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "FaceBook ADs",
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
            // crossAxisAlignment: CrossAxisAlignment.start,
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
              Container(
                width: 320,
                height: 60,
                // alignment: Alignment.center,
                // child: currentAd,
                child: FaceBookAdsHelpper.faceBookAdsHelpper.banner(),
              ),
              const Divider(
                color: Colors.white,
              ),
              Container(
                width: 320,
                height: 260,
                child: FaceBookAdsHelpper.faceBookAdsHelpper.mediumRectangle(),
              ),
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
                  FaceBookAdsHelpper.faceBookAdsHelpper.intertiatialAd();
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
                  FaceBookAdsHelpper.faceBookAdsHelpper.rewarded();
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
              FaceBookAdsHelpper.faceBookAdsHelpper.nativeBanner(),
              const Divider(
                color: Colors.white,
              ),
              FaceBookAdsHelpper.faceBookAdsHelpper.native(),
            ],
          ),
        ),
      ),
    );
  }
}
