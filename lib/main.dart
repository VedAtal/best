import 'package:best/desktop/desktop_home.dart';
import 'package:best/desktop/desktop_juntos.dart';
import 'package:best/desktop/desktop_tracker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'desktop/desktop_welcome.dart';
import 'extensions/responsive_layout.dart';
import 'global/mobile_message.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAWXyqH6a3o4Wf4vxhQV3xg8tBv0Jr6WCU",
      authDomain: "best-bs.firebaseapp.com",
      projectId: "best-bs",
      storageBucket: "best-bs.appspot.com",
      messagingSenderId: "833850868898",
      appId: "1:833850868898:web:dfe402c2557d6f4dc503fb",
      measurementId: "G-61THLLGX42"
    ),
  );

  runApp(const BeST());
}

class BeST extends StatelessWidget {
  const BeST({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeST',
      theme: ThemeData(
        textTheme: GoogleFonts.lexendTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const ResponsiveLayout(DesktopWelcome(), MobileMessage()),
    );
  }
}
