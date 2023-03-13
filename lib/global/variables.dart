import 'package:best/desktop/desktop_home.dart';
import 'package:best/desktop/desktop_juntos.dart';
import 'package:best/desktop/desktop_tracker.dart';
import 'package:best/global/mobile_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../extensions/responsive_layout.dart';

class Variables {
  // firebase vars
  static User? user = FirebaseAuth.instance.currentUser;

  // vars
  static var pages = [
    'Home',
    'Tracker',
    'Juntos',
  ];

  static var pageRoutes = {
    'Home': const ResponsiveLayout(DesktopHome(), MobileMessage()),
    'Tracker': const ResponsiveLayout(DesktopTracker(), MobileMessage()),
    'Juntos': const ResponsiveLayout(DesktopJuntos(), MobileMessage()),
  };

  static var skills = {
    'Mindful Self': [
      {'Healthy Habits': 0},
      {'Growth Mindset': 0},
      {'Self-Direction': 0},
      {'Self-Reflection/Journaling': 0},
      {'Emotional Self-Regulation': 0},
      {'Good Judgement': 0},
      {'Confidence+Courage': 0},
      {'Cultivating Gratitude+Humility': 0},
      {'Curiosity+Imagination': 0},
      {'Wayfinding': 0},
      {'Individual Sport': 0},
    ],
    'Servant Leader': [
      {'Warm-Hearted': 0},
      {'Tough-Minded': 0},
      {'Peer Support': 0},
      {'Conflict Resolution and Negotiation': 0},
      {'Citizenship': 0},
      {'Team Sport': 0},
      {'Collaborative Teamwork': 0},
      {'Community Volunteering': 0},
      {'Event Organizer or Volunteer': 0},
      {'Enterprising Entrepreneurship': 0},
      {'Zest+Humor': 0},
    ],
    'Compelling Communicator': [
      {'Reading': 0},
      {'Spelling': 0},
      {'Grammar': 0},
      {'Vocabulary Expansion': 0},
      {'Keyboard/Typing': 0},
      {'Nonfiction Writing': 0},
      {'Fiction Writing': 0},
      {'Writing Feedback': 0},
      {'Multimedia': 0},
      {'Presenting': 0},
      {'Active Listening': 0},
      {'Foreign Language': 0},
    ],
    'Critical Thinker and Problem Solver': [
      {'Math Problem Solving': 0},
      {'Socratic Dialogue/Debate': 0},
      {'Evidence Evaluation': 0},
      {'Textual Analysis': 0},
      {'Inquiry-Based Investigation': 0},
      {'Financial Literacy': 0},
      {'Coding+Algorithim Structuring': 0},
      {'Modeling+Simulations': 0},
      {'Decision Analysis': 0},
      {'Creative Problem-Solving Approaches': 0},
    ],
    'Creative Maker': [
      {'Innovative Design Thinking': 0},
      {'Art': 0},
      {'Cooking': 0},
      {'Music': 0},
      {'Theater': 0},
      {'Video Creation': 0},
      {'Making': 0},
      {'Graphic Design+Animation': 0},
      {'Digital Design+Fabrication': 0},
      {'Engineering+Robotics': 0},
    ],
  };

  // colors
  static const Color teal = Color.fromARGB(255, 26, 166, 159);
  static const Color gold = Color.fromARGB(255, 238, 176, 5);
  static const Color translucentTeal = Color.fromARGB(155, 26, 166, 159);
  static const Color translucentGold = Color.fromARGB(155, 238, 176, 5);

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
