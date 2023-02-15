import 'package:flutter/material.dart';
import 'package:training_app/views/homepage/homepage.dart';
import 'package:training_app/views/weekly_tasks/12th%20week%20task/bloc_management.dart';
import 'package:training_app/views/weekly_tasks/12th%20week%20task/provider_management.dart';
import 'package:training_app/views/weekly_tasks/12th%20week%20task/redux_management.dart';
import 'package:training_app/views/weekly_tasks/Eight%20week%20task/action_sheet_page.dart';
import 'package:training_app/views/weekly_tasks/Eight%20week%20task/animation_page.dart';
import 'package:training_app/views/weekly_tasks/Eight%20week%20task/localization_page.dart';
import 'package:training_app/views/weekly_tasks/Eight%20week%20task/orientation_page.dart';
import 'package:training_app/views/weekly_tasks/Eight%20week%20task/responsive_page.dart';
import 'package:training_app/views/weekly_tasks/Eight%20week%20task/universal_page.dart';
import 'package:training_app/views/weekly_tasks/Eleven%20Week%20Task/flutter_slivers.dart';
import 'package:training_app/views/weekly_tasks/Eleven%20Week%20Task/method_chanel.dart';
import 'package:training_app/views/weekly_tasks/Eleven%20Week%20Task/save_files.dart';
import 'package:training_app/views/weekly_tasks/Eleven%20Week%20Task/view_file.dart';
import 'package:training_app/views/weekly_tasks/Fifth%20week%20task/audio_player.dart';
import 'package:training_app/views/weekly_tasks/Fifth%20week%20task/social_media_logIn.dart';
import 'package:training_app/views/weekly_tasks/Fifth%20week%20task/video_player.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/Navigation/Third_screen.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/Navigation/first_screen.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/dartprogramming.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/installflutter.dart';
import 'package:training_app/views/weekly_tasks/First%20week%20tasks/introofflutter.dart';
import 'package:training_app/views/weekly_tasks/Forth%20Week%20Task/callPage.dart';
import 'package:training_app/views/weekly_tasks/Forth%20Week%20Task/lazy_loading_page.dart';
import 'package:training_app/views/weekly_tasks/Forth%20Week%20Task/mail_page.dart';
import 'package:training_app/views/weekly_tasks/Forth%20Week%20Task/map_screen.dart';
import 'package:training_app/views/weekly_tasks/Forth%20Week%20Task/message_page.dart';
import 'package:training_app/views/weekly_tasks/Forth%20Week%20Task/send_messege.dart';
import 'package:training_app/views/weekly_tasks/Nineth%20Week%20Task/AuthenticationScreen.dart';
import 'package:training_app/views/weekly_tasks/Nineth%20Week%20Task/cloud_fire_store/FireStoreDatabaseScreen.dart';
import 'package:training_app/views/weekly_tasks/Nineth%20Week%20Task/forgot_pass_word.dart';
import 'package:training_app/views/weekly_tasks/Nineth%20Week%20Task/realTimeDatabaseScreen.dart';
import 'package:training_app/views/weekly_tasks/Nineth%20Week%20Task/view_data_real_time_data_base.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/custom_controls.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/data_passing/add_data.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/data_passing/showdata.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/layouts/Food%20Delivery%20Pages/food_app_home_page.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/layouts/bottom_navigation_page.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/layouts/drawer_page.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/layouts/layout_controlls.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/layouts/tab_bar_page.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/DropdownButtonScreen.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/alert_dialog_page.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/all_widget_list.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/date_picker_pagee.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/grid_view.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/image.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/list_view.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/popUpMenuScreen.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/slider_page.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/snack_bar_page.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/stack_screen.dart';
import 'package:training_app/views/weekly_tasks/Second%20week%20Tasks/widgets/time_picker_page.dart';
import 'package:training_app/views/weekly_tasks/Seventh%20week%20Task/built_in_camera.dart';
import 'package:training_app/views/weekly_tasks/Seventh%20week%20Task/cameraPage.dart';
import 'package:training_app/views/weekly_tasks/Seventh%20week%20Task/default_camera.dart';
import 'package:training_app/views/weekly_tasks/Seventh%20week%20Task/in_app_purchase_page.dart';
import 'package:training_app/views/weekly_tasks/Seventh%20week%20Task/payment_gateway_stripe.dart';
import 'package:training_app/views/weekly_tasks/Seventh%20week%20Task/payment_geteway.dart';
import 'package:training_app/views/weekly_tasks/Seventh%20week%20Task/pull_to_refresh_page.dart';
import 'package:training_app/views/weekly_tasks/Sixth%20Week%20Tasks/ad_mob_page.dart';
import 'package:training_app/views/weekly_tasks/Sixth%20Week%20Tasks/share_all_social_sending.dart';
import 'package:training_app/views/weekly_tasks/Sixth%20Week%20Tasks/sharing_page.dart';
import 'package:training_app/views/weekly_tasks/Tenth%20Week%20Task/analytics_screen.dart';
import 'package:training_app/views/weekly_tasks/Tenth%20Week%20Task/crashlutics_screen.dart';
import 'package:training_app/views/weekly_tasks/Tenth%20Week%20Task/dynamic_link_page.dart';
import 'package:training_app/views/weekly_tasks/Tenth%20Week%20Task/notification_screen.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/add_api_data.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/api_calling_page.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/draggable_page.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/gestures_page.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/image_picker.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/insertdata_page.dart';
import 'package:training_app/views/weekly_tasks/Third%20week%20task/sqlite_db_page.dart';
import 'package:training_app/views/weekly_tasks/Week8.dart';
import 'package:training_app/views/weekly_tasks/week1.dart';
import 'package:training_app/views/weekly_tasks/week10.dart';
import 'package:training_app/views/weekly_tasks/week11.dart';
import 'package:training_app/views/weekly_tasks/week12.dart';
import 'package:training_app/views/weekly_tasks/week2.dart';
import 'package:training_app/views/weekly_tasks/week3.dart';
import 'package:training_app/views/weekly_tasks/week4.dart';
import 'package:training_app/views/weekly_tasks/week5.dart';
import 'package:training_app/views/weekly_tasks/week6.dart';
import 'package:training_app/views/weekly_tasks/week7.dart';
import 'package:training_app/views/weekly_tasks/week9.dart';
import '../views/weekly_tasks/Eleven Week Task/state_managment.dart';
import '../views/weekly_tasks/Nineth Week Task/sign_up_page.dart';
import '../views/weekly_tasks/Nineth Week Task/user_details.dart';
import '../views/weekly_tasks/Sixth Week Tasks/face_book_ads_page.dart';
import '../views/weekly_tasks/Sixth Week Tasks/share_default_intent.dart';
import 'app_routes.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes().homePage: (context) => const HomePage(),
  AppRoutes().week1: (context) => const Week1(),
  AppRoutes().week2: (context) => const Week2(),
  AppRoutes().week3: (context) => const Week3(),
  AppRoutes().week4: (context) => const Week4(),
  AppRoutes().week5: (context) => const Week5(),
  AppRoutes().week6: (context) => const Week6(),
  AppRoutes().week7: (context) => const Week7(),
  AppRoutes().week8: (context) => const Week8(),
  AppRoutes().week9: (context) => const Week9(),
  AppRoutes().week10: (context) => const Week10(),
  AppRoutes().week11: (context) => const Week11(),
  AppRoutes().week12: (context) => const Week12(),
  AppRoutes().introOfFlutter: (context) => const IntroOfFlutter(),
  AppRoutes().installFlutter: (context) => const InstallFlutter(),
  AppRoutes().dartProgramming: (context) => const DartProgramming(),
  AppRoutes().firstNavigationScreen: (context) => const FirstNavigationScreen(),
  AppRoutes().thirdNavigationScreen: (context) => const ThirdNavigationScreen(),
  AppRoutes().addDataScreen: (context) => const AddDataScreen(),
  AppRoutes().editDataScreen: (context) => const ShowDataScreen(),
  AppRoutes().allWidgetsScreen: (context) => const AllWidgets(),
  AppRoutes().imageScreen: (context) => const ImageShower(),
  AppRoutes().dropDownButtonScreen: (context) => const DropDownButtonPage(),
  AppRoutes().popUpMenuScreen: (context) => const PopUpMenuScreen(),
  AppRoutes().listViewScreen: (context) => const ListViewScreen(),
  AppRoutes().gridViewScreen: (context) => const GridViewScreen(),
  AppRoutes().stackScreen: (context) => const StackPage(),
  AppRoutes().datePickerScreen: (context) => const DatePickerPage(),
  AppRoutes().timePickerScreen: (context) => const TimePickerPage(),
  AppRoutes().alertDialogScreen: (context) => const AlertDialogPage(),
  AppRoutes().snackBarScreen: (context) => const SnackBarPage(),
  AppRoutes().sliderScreen: (context) => const SliderPage(),
  AppRoutes().layoutsScreen: (context) => const LayOutScreen(),
  AppRoutes().drawerScreen: (context) => const DrawerPage(),
  AppRoutes().tabBarScreen: (context) => const TabBarPage(),
  AppRoutes().customControlsScreen: (context) => const CustomControlsPage(),
  AppRoutes().bottomNavigationScreen: (context) => const BottomNavigationPage(),
  AppRoutes().foodAppHomePageScreen: (context) => const FoodAppHomePage(),
  AppRoutes().gesturesScreen: (context) => const GesturesPage(),
  AppRoutes().sqLiteDBScreen: (context) => const SqliteDBPage(),
  AppRoutes().imagePickerScreen: (context) => const ImagePikerPage(),
  AppRoutes().insertDataScreen: (context) => const InsertData(),
  AppRoutes().apiCallingScreen: (context) => const ApiCallingPage(),
  AppRoutes().apiAddDataScreen: (context) => const AddApiDataPage(),
  AppRoutes().draggableScreen: (context) => const DraggablePage(),
  AppRoutes().lazyLoadingScreen: (context) => const LazyLoadingPage(),
  AppRoutes().sendCallSMSEmailScreen: (context) => const SendMessege(),
  AppRoutes().sendCallScreen: (context) => const CallingPage(),
  AppRoutes().sendSMSScreen: (context) => const MessageSendPage(),
  AppRoutes().sendMessagesScreen: (context) => const SendEmailPage(),
  AppRoutes().mapIntegrationScreen: (context) => const MapScreen(),
  AppRoutes().audioPlayerScreen: (context) => const AudioPlayerPage(),
  AppRoutes().videoPlayerScreen: (context) => const VideoPlayerPage(),
  AppRoutes().socialMediaLogInScreen: (context) => const SocialMediaLogInPage(),
  AppRoutes().adMobsScreen: (context) => const AdMobPage(),
  AppRoutes().faceBookAdsScreen: (context) => const FaceBookAdsPage(),
  AppRoutes().socialSharingScreen: (context) => const SocialSharingPage(),
  AppRoutes().sharingScreen: (context) => const SharingPage(),
  AppRoutes().shareDefaultIntentScreen: (context) => const ShareDefaultIntentPage(),
  AppRoutes().cameraScreen: (context) => const CameraPage(),
  AppRoutes().builtInCameraScreen: (context) => const BuiltInCameraPage(),
  AppRoutes().pullToRefreshScreen: (context) => const PullToRefreshPage(),
  AppRoutes().inAppPurchaseScreen: (context) => const InAppPurchasePage(),
  AppRoutes().paymentGateWayScreen: (context) => const PaymentGateWayPage(),
  AppRoutes().paymentGateWayStripeScreen: (context) => const PaymentGateWayStripePage(),
  AppRoutes().actionSheetScreen: (context) => const ActionSheetPage(),
  AppRoutes().responsiveScreen: (context) => const ResponsivePage(),
  AppRoutes().orientationScreen: (context) => const OrientationPage(),
  AppRoutes().animationScreen: (context) => const AnimationPage(),
  AppRoutes().localizationScreen: (context) => const LocalizationPage(),
  AppRoutes().universalScreen: (context) => const UniversalPage(),
  AppRoutes().defaultCameraScreen: (context) => const DefaultCamera(),
  AppRoutes().authenticationScreen: (context) => const AuthenticationScreen(),
  AppRoutes().signUpScreen: (context) => const SignUpPage(),
  AppRoutes().userDetailsScreen: (context) => const UserDetailsPage(),
  AppRoutes().forGotPassWordScreen: (context) => const ForGotPassWordPage(),
  AppRoutes().realTimeDatabaseScreen: (context) => const RealTimeDatabaseScreen(),
  AppRoutes().viewRealTimeDatabaseScreen: (context) => const RealTimeDataBaseViewDataPage(),
  AppRoutes().fireStoreDatabaseScreen: (context) => const FireStoreDatabaseScreen(),
  AppRoutes().analyticsScreen: (context) => const AnalyticsScreen(),
  AppRoutes().crashlyticsScreen: (context) => const CrashlyticsScreen(),
  AppRoutes().dynamicLinksScreen: (context) => const DynamicLinksScreen(),
  AppRoutes().notificationScreen: (context) => const NotificationScreen(),
  AppRoutes().sliversScreen: (context) => const FlutterSliversPage(),
  AppRoutes().saveFileLocallyScreen: (context) => const SaveFileLocallyPage(),
  AppRoutes().viewFileLocallyScreen: (context) => const ViewFileLocallyScreen(),
  AppRoutes().methodChanelScreen: (context) => const MethodChanelPage(),
  AppRoutes().stateManagementScreen: (context) => const StateManagement(),
  AppRoutes().blocManagementScreen: (context) => const BlocManagementScreen(),
  AppRoutes().blocApiScreen: (context) => const APIExampleOfBloc(),
  AppRoutes().providerManagementScreen: (context) => const ProviderManagementScreen(),
  AppRoutes().reduxManagementScreen: (context) => const ReduxManagementScreen(),
};
