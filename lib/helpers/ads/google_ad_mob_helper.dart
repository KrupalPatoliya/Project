import 'dart:developer';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMob {
  AdMob._();

  static final AdMob adMob = AdMob._();

  BannerAd? myBanner;
  InterstitialAd? interstitialAd;
  InterstitialAd? interstitialVideoAd;
  RewardedAd? rewardedAd;
  RewardedInterstitialAd? rewardedInterstitialAd;
  NativeAd? myNative;
  NativeAd? myNativeVideo;

  bannerAd() {
    print("====================================");
    print("banner AD called");
    print("====================================");
    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    myBanner!.load().then((value) {
      print("============================");
      print("Ad Loaded");
      print("============================");
    });
  }

  interstitial() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  interstitialVideo() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/8691691433',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          interstitialVideoAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  rewardAd() {
    RewardedAd.load(
      request: const AdRequest(),
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  rewardInterstitialAd() {
    RewardedInterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5354046379',
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          print('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          rewardedInterstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedInterstitialAd failed to load: $error');
        },
      ),
    );
  }

  nativeAds() {
    const String adUnitIDNative = "ca-app-pub-3940256099942544/2247696110";
    myNative = NativeAd(
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      factoryId: "listTile",
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdFailedToLoad: (Ad, LoadAdError) {
          print("=================================================");
          print('natty $Ad loaded.');
          print('natty $LoadAdError loaded.');
          print("=================================================");
        },
        onAdLoaded: (Ad ad) {
          print('natty $NativeAd loaded.');

          myNative = ad as NativeAd?;
        },
      ),
    );
    myNative!.load();
  }

// nativeVideoAds() {
//   print("====================================");
//   print("ad start to Loading");
//   print("====================================");
//   const _adUnitIDNative = "ca-app-pub-3940256099942544/1044960115";
//   myNativeVideo = NativeAd(
//     adUnitId: _adUnitIDNative,
//     factoryId: 'listTileVideo',
//     request: const AdRequest(),
//     listener: NativeAdListener(
//       onAdLoaded: (Ad ad) {
//         print('natty $NativeAd loaded.');
//         print("====================================");
//         print("ad Loaded");
//         print("====================================");
//         myNativeVideo = ad as NativeAd?;
//       },
//     ),
//   );
//
//   myNativeVideo!.load().then((value) {
//     print("====================================");
//     print("ad Loaded");
//     print("====================================");
//   });
// }
}
