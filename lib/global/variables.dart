import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Variables {
  // firebase vars
  static User? user = FirebaseAuth.instance.currentUser;

  // colors
  static const Color teal = Color.fromRGBO(26, 166, 159, 100);
  static const Color gold = Color.fromARGB(255, 238, 176, 5);
  static const Color backgroundTeal = Color.fromARGB(156, 214, 243, 243);

  // methods
  static void bsRedirect() async {
    Uri url = Uri.http('besomeone.vip');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
