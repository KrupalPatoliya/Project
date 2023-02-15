import 'package:camera/camera.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:training_app/provider/counter_provider.dart';
import 'package:training_app/provider/language_provider.dart';
import 'package:training_app/utils/app_routes.dart';
import 'package:training_app/utils/routes.dart';
import 'package:training_app/utils/strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'helpers/fire_base/fire_base_dynamic_link_create.dart';
import 'provider/theme_Provider.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  await FacebookAudienceNetwork.init();
  cameras = await availableCameras();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseInAppMessaging firebaseInAppMessaging = FirebaseInAppMessaging.instance;

  firebaseInAppMessaging.setAutomaticDataCollectionEnabled(true);

  await messaging.setAutoInitEnabled(true);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final fcmToken = await messaging.getToken();
  final fmc = await messaging.getAPNSToken();
  print(fcmToken);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (message.notification != null) {
      var androidDetails = const AndroidNotificationDetails(
        "Chanel Name",
        "Chanel Name",
        priority: Priority.high,
        importance: Importance.max,
      );
      var iOSDetails = const DarwinNotificationDetails();
      var platformDetails = NotificationDetails(android: androidDetails, iOS: iOSDetails);
      await flutterLocalNotificationsPlugin.show(0, message.notification!.title, message.notification!.body, platformDetails,
          payload: 'Simple Notification');
    }
  });

  Stripe.publishableKey = "pk_test_51MMn8eSDaDr46PdITHtLWBezcc9w5kFPkxcHzl9JeDkvPnmJ2dZNqifvzbpjGRGRWTjmpHJevl5QUYH95h6rrk54001emLyU44";

  runApp(
    ChangeNotifierProvider<LanguageProvider>(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),
    // const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Training App',
            initialRoute: AppRoutes().homePage,
            routes: routes,
            themeMode: (Provider
                .of<ThemeProvider>(context)
                .obj
                .isDark)
                ? ThemeMode.light
                : ThemeMode.dark,
            theme: ThemeData(
              backgroundColor: Colors.white12,
              unselectedWidgetColor: Colors.white,
              splashColor: Colors.transparent,

            ),
            darkTheme: ThemeData(
              backgroundColor: Colors.black12,
              unselectedWidgetColor: Colors.white,
              splashColor: Colors.transparent,
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate, // Add this line
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: value.locale,
            supportedLocales: const [
              Locale('es', ''), // Spanish
              Locale('en', ''), // English
              Locale('hi', ''), // Hindi
              Locale('gu', ''), // Gujarati
              Locale('mr', ''), // Marathi
              Locale('ru', ''), // Russian
            ],
          );
        },
      ),
    );
  }
}
