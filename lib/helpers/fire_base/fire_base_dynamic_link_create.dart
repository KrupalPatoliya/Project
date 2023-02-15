import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../../utils/app_routes.dart';

class FireBaseDynamicLinkCreating {
  FireBaseDynamicLinkCreating._();

  static final FireBaseDynamicLinkCreating fireBaseDynamicLinkCreating = FireBaseDynamicLinkCreating._();

  Future<String> createLink() async {
    DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://krupalitrainyapp.page.link?res=erfdvx"),
      // link: Uri.parse("https://krupalitrainyapp.page.link/?res=erfdvx"),
      uriPrefix: "https://krupalitrainyapp.page.link",
      androidParameters: const AndroidParameters(packageName: "com.training_app.training_app"),
    );
    ShortDynamicLink dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.short,
    );

    return dynamicLink.shortUrl.toString();
  }

  Future<String> createPageLink() async {
    DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://krupalitrainyapp.page.link?page=page"),
      uriPrefix: "https://krupalitrainyapp.page.link",
      androidParameters: const AndroidParameters(packageName: "com.training_app.training_app"),
    );
    ShortDynamicLink dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      shortLinkType: ShortDynamicLinkType.short,
    );

    return dynamicLink.shortUrl.toString();
  }

  getDynamicLink({required BuildContext context}) async {
    PendingDynamicLinkData? dynamicLink = await FirebaseDynamicLinks.instance.getInitialLink();

    Uri link = dynamicLink!.link;

    if (link.queryParameters["page"] == "page") {
      Navigator.of(context).pushNamed(AppRoutes().dynamicLinksScreen);
    } else {
    }
  }
}
