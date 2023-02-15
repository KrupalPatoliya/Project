import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

class FaceBookAdsHelpper {
  FaceBookAdsHelpper._();

  static FaceBookAdsHelpper faceBookAdsHelpper = FaceBookAdsHelpper._();

  Widget banner() {
    return FacebookBannerAd(
      placementId: "IMG_16_9_LINK#YOUR_PLACEMENT_ID",
      bannerSize: BannerSize.STANDARD,
      // keepAlive: true,
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
  }

  Widget mediumRectangle() {
    return FacebookBannerAd(
      placementId: "IMG_16_9_LINK#YOUR_PLACEMENT_ID",
      bannerSize: BannerSize.MEDIUM_RECTANGLE,
      // keepAlive: true,
      listener: (result, value) {
        switch (result) {
          case BannerAdResult.ERROR:
            print("Error: $value");
            break;
          case BannerAdResult.LOADED:
            print("Loaded: $value");
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
  }

  Widget native() {
    return FacebookNativeAd(
      placementId: "CAROUSEL_IMG_SQUARE_APP_INSTALL#YOUR_PLACEMENT_ID",
      adType: NativeAdType.NATIVE_AD,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.red,
      buttonBorderColor: Colors.white,
      isMediaCover: true,
      labelColor: Colors.pink,
      keepAlive: true,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }

  Widget nativeBanner() {
    return FacebookNativeAd(
      placementId: "CAROUSEL_IMG_SQUARE_APP_INSTALL#YOUR_PLACEMENT_ID",
      adType: NativeAdType.NATIVE_BANNER_AD,
      // bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      // width: double.infinity,
      height: 50,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      keepAlive: true,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
    );
  }

  intertiatialAd() async {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED) {
          FacebookInterstitialAd.showInterstitialAd();
        }

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED && value["invalidated"] == true) {
          // intertiatialAd();
        }
      },
    );
  }

  rewarded() async {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "VID_HD_9_16_39S_APP_INSTALL#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) {
          FacebookRewardedVideoAd.showRewardedVideoAd();
        }
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE &&
            result == RewardedVideoAdResult.VIDEO_CLOSED &&
            (value == true || value["invalidated"] == true)) {
          // rewarded();
        }
      },
    );
  }
}
