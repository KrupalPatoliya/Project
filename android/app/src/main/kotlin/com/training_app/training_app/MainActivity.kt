package com.training_app.training_app

//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.android.FlutterFragmentActivity

//class MainActivity: FlutterFragmentActivity() {
//
//}


//import androidx.annotation.NonNull

// COMPLETE: Import io.flutter.embedding.engine.FlutterEngine
// COMPLETE: Import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

import android.bluetooth.BluetoothAdapter
import android.net.ConnectivityManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterActivity() {

    private val CHANNEL = "GetNumber"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getRandomNumber") {

                val connManager =
                    context.getSystemService(CONNECTIVITY_SERVICE) as ConnectivityManager

                if ((connManager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE) != null
                            &&
                            connManager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE)!!.isConnectedOrConnecting())
                ) {
                    result.success("Phone Data Connected")
                } else if (connManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI) != null
                    && connManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI)!!.isConnectedOrConnecting()
                ) {
                    result.success("Wifi Data Connected")
                } else {
                    result.success("Not-Connected")
                }
            } else {
                result.notImplemented()
            }
        }

        // TODO: Register the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "listTile", ListTileNativeAdFactory(context)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "listTileMedium", NativeAdFactoryMedium(context)
        );

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "listTileVideo", NativeVideoAdFactory(context)
        );

    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        // TODO: Unregister the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile");
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileMedium");
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileVideo");
    }

//
//    private fun getBatteryLevel(): Int {
//        val batteryLevel: bool
//        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
//            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
//            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
//        } else {
//            val intent = ContextWrapper(applicationContext).registerReceiver(
//                null,
//                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
//            )
//            batteryLevel =
//                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
//                    BatteryManager.EXTRA_SCALE,
//                    -1
//                )
//        }
//
//        return batteryLevel
//    }

}