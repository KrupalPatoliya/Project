import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

class AdsPage extends StatefulWidget {
  final String idfa;

  const AdsPage({Key? key, this.idfa = ''}) : super(key: key);

  @override
  AdsPageState createState() => AdsPageState();
}

class AdsPageState extends State<AdsPage> {
  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;

  /// All widget ads are stored in this variable. When a button is pressed, its
  /// respective ad widget is set to this variable and the view is rebuilt using
  /// setState().
  Widget _currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void initState() {
    super.initState();

    /// please add your own device testingId
    /// (testingId will print in console if you don't provide  )
    FacebookAudienceNetwork.init(
      testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6",
      // iOSAdvertiserTrackingEnabled: true,
    );

    _loadInterstitialAd();
    _loadRewardedVideoAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED) _isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED && value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "VID_HD_9_16_39S_APP_INSTALL#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) _isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE && result == RewardedVideoAdResult.VIDEO_CLOSED && (value == true || value["invalidated"] == true)) {
        _isRewardedAdLoaded = false;
        _loadRewardedVideoAd();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Align(
              alignment: const Alignment(0, -1.0),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _getAllButtons(),
              ),
            ),
          ),
          // Column(children: <Widget>[
          //   _nativeAd(),
          //   // _nativeBannerAd(),
          //   _nativeAd(),
          // ],),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Align(
              alignment: const Alignment(0, 1.0),
              child: _currentAd,
            ),
          )
        ],
      ),
    );
  }

  Widget _getAllButtons() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: <Widget>[
        _getRaisedButton(title: "Banner Ad", onPressed: _showBannerAd),
        _getRaisedButton(title: "Native Ad", onPressed: _showNativeAd),
        _getRaisedButton(title: "Native Banner Ad", onPressed: _showNativeBannerAd),
        _getRaisedButton(title: "Interstitial Ad", onPressed: _showInterstitialAd),
        _getRaisedButton(title: "Rewarded Ad", onPressed: _showRewardedAd),
      ],
    );
  }

  Widget _getRaisedButton({required String title, void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd();
    } else {
      print("Interstitial Ad not yet loaded!");
    }
  }

  _showRewardedAd() {
    if (_isRewardedAdLoaded == true) {
      FacebookRewardedVideoAd.showRewardedVideoAd();
    } else {
      print("Rewarded Ad not yet loaded!");
    }
  }

  _showBannerAd() {
    setState(() {
      _currentAd = FacebookBannerAd(
        // placementId: "YOUR_PLACEMENT_ID",
        placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID", //test id
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
  }

  _showNativeBannerAd() {
    setState(() {
      _currentAd = _nativeBannerAd();
    });
  }

  Widget _nativeBannerAd() {
    return FacebookNativeAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    );
  }

  _showNativeAd() {
    setState(() {
      _currentAd = _nativeAd();
    });
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.blue,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }
}
