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

  static var skillsSP = <String, Map<String, int>>{
    'Mindful Self': {
      'Healthy Habits': 0,
      'Growth Mindset': 0,
      'Self-Direction': 0,
      'Self-Reflection/Journaling': 0,
      'Emotional Self-Regulation': 0,
      'Good Judgement': 0,
      'Confidence+Courage': 0,
      'Cultivating Gratitude+Humility': 0,
      'Curiosity+Imagination': 0,
      'Wayfinding': 0,
      'Individual Sport': 0
    },
    'Servant Leader': {
      'Warm-Hearted': 0,
      'Tough-Minded': 0,
      'Peer Support': 0,
      'Conflict Resolution and Negotiation': 0,
      'Citizenship': 0,
      'Team Sport': 0,
      'Collaborative Teamwork': 0,
      'Community Volunteering': 0,
      'Event Organizer or Volunteer': 0,
      'Enterprising Entrepreneurship': 0,
      'Zest+Humor': 0,
    },
    'Compelling Communicator': {
      'Reading': 0,
      'Spelling': 0,
      'Grammar': 0,
      'Vocabulary Expansion': 0,
      'Keyboard/Typing': 0,
      'Nonfiction Writing': 0,
      'Fiction Writing': 0,
      'Writing Feedback': 0,
      'Multimedia': 0,
      'Presenting': 0,
      'Active Listening': 0,
      'Foreign Language': 0,
    },
    'Critical Thinker': {
      'Math Problem Solving': 0,
      'Socratic Dialogue/Debate': 0,
      'Evidence Evaluation': 0,
      'Textual Analysis': 0,
      'Inquiry-Based Investigation': 0,
      'Financial Literacy': 0,
      'Coding+Algorithim Structuring': 0,
      'Modeling+Simulations': 0,
      'Decision Analysis': 0,
      'Creative Problem-Solving Approaches': 0,
    },
    'Creative Maker': {
      'Innovative Design Thinking': 0,
      'Art': 0,
      'Cooking': 0,
      'Music': 0,
      'Theater': 0,
      'Video Creation': 0,
      'Making': 0,
      'Graphic Design+Animation': 0,
      'Digital Design+Fabrication': 0,
      'Engineering+Robotics': 0,
    },
  };

  static var skillTopics = [
    'Mindful Self',
    'Servant Leader',
    'Compelling Communicator',
    'Critical Thinker',
    'Creative Maker',
  ];

  static var skills = {
    'Mindful Self': [
      'Healthy Habits',
      'Growth Mindset',
      'Self-Direction',
      'Self-Reflection/Journaling',
      'Emotional Self-Regulation',
      'Good Judgement',
      'Confidence+Courage',
      'Cultivating Gratitude+Humility',
      'Curiosity+Imagination',
      'Wayfinding',
      'Individual Sport'
    ],
    'Servant Leader': [
      'Warm-Hearted',
      'Tough-Minded',
      'Peer Support',
      'Conflict Resolution and Negotiation',
      'Citizenship',
      'Team Sport',
      'Collaborative Teamwork',
      'Community Volunteering',
      'Event Organizer or Volunteer',
      'Enterprising Entrepreneurship',
      'Zest+Humor',
    ],
    'Compelling Communicator': [
      'Reading',
      'Spelling',
      'Grammar',
      'Vocabulary Expansion',
      'Keyboard/Typing',
      'Nonfiction Writing',
      'Fiction Writing',
      'Writing Feedback',
      'Multimedia',
      'Presenting',
      'Active Listening',
      'Foreign Language',
    ],
    'Critical Thinker': [
      'Math Problem Solving',
      'Socratic Dialogue/Debate',
      'Evidence Evaluation',
      'Textual Analysis',
      'Inquiry-Based Investigation',
      'Financial Literacy',
      'Coding+Algorithim Structuring',
      'Modeling+Simulations',
      'Decision Analysis',
      'Creative Problem-Solving Approaches',
    ],
    'Creative Maker': [
      'Innovative Design Thinking',
      'Art',
      'Cooking',
      'Music',
      'Theater',
      'Video Creation',
      'Making',
      'Graphic Design+Animation',
      'Digital Design+Fabrication',
      'Engineering+Robotics',
    ],
  };

  static var skillDescriptions = {
    'Mindful Self': 'Intrapersonal + Bodily-Kinesthetic IQ', // talent 1
    'Healthy Habits': '',
    'Growth Mindset': '',
    'Self-Direction': '',
    'Self-Reflection/Journaling': '',
    'Emotional Self-Regulation': '',
    'Good Judgement': '',
    'Confidence+Courage': '',
    'Cultivating Gratitude+Humility': '',
    'Curiosity+Imagination': '',
    'Wayfinding': '',
    'Individual Sport': '',
    'Servant Leader': 'Interpersonal IQ', // talent 2
    'Warm-Hearted': '',
    'Tough-Minded': '',
    'Peer Support': '',
    'Conflict Resolution and Negotiation': '',
    'Citizenship': '',
    'Team Sport': '',
    'Collaborative Teamwork': '',
    'Community Volunteering': '',
    'Event Organizer or Volunteer': '',
    'Enterprising Entrepreneurship': '',
    'Zest+Humor': '',
    'Compelling Communicator': 'Verbal-Linguistic IQ', // talent 3
    'Reading': '',
    'Spelling': '',
    'Grammar': '',
    'Vocabulary Expansion': '',
    'Keyboard/Typing': '',
    'Nonfiction Writing': '',
    'Fiction Writing': '',
    'Writing Feedback': '',
    'Multimedia': '',
    'Presenting': '',
    'Active Listening': '',
    'Foreign Language': '',
    'Critical Thinker': 'Logical-Mathematical IQ', // talent 4
    'Math Problem Solving': '',
    'Socratic Dialogue/Debate':
        'Cooperative argumentative dialogue between individuals, based on asking and answering '
            'questions to stimulate critical thinking and to draw out ideas and underlying '
            'presuppositions. Can be online or in-person.',
    'Evidence Evaluation': '',
    'Textual Analysis': '',
    'Inquiry-Based Investigation': '',
    'Financial Literacy': '',
    'Coding+Algorithim Structuring': '',
    'Modeling+Simulations': '',
    'Decision Analysis': '',
    'Creative Problem-Solving Approaches': '',
    'Creative Maker': 'Visual-Spatial + Musical IQ', // talent 5
    'Innovative Design Thinking': '',
    'Art': '',
    'Cooking': '',
    'Music': '',
    'Theater': '',
    'Video Creation': '',
    'Making': '',
    'Graphic Design+Animation': '',
    'Digital Design+Fabrication': '',
    'Engineering+Robotics': '',
  };

  // colors
  static const Color teal = Color.fromARGB(255, 26, 166, 159);
  static const Color gold = Color.fromARGB(255, 238, 176, 5);
  static const Color translucentTeal = Color.fromARGB(155, 26, 166, 159);
  static const Color translucentGold = Color.fromARGB(155, 238, 176, 5);

  static const Color mindfulSelf = Color.fromRGBO(53, 186, 106, 1.0);
  static const Color servantLeader = Color.fromRGBO(250, 143, 66, 1.0);
  static const Color compellingCommunicator = Color.fromRGBO(255, 176, 22, 1.0);
  static const Color criticalThinker = Color.fromRGBO(32, 118, 255, 1.0);
  static const Color creativeMaker = Color.fromRGBO(156, 72, 184, 1.0);

  static const Color mindfulSelfTranslucent = Color.fromRGBO(53, 186, 106, 0.3);
  static const Color servantLeaderTranslucent =
      Color.fromRGBO(250, 143, 66, 0.3);
  static const Color compellingCommunicatorTranslucent =
      Color.fromRGBO(255, 176, 22, 0.3);
  static const Color criticalThinkerTranslucent =
      Color.fromRGBO(32, 118, 255, 0.3);
  static const Color creativeMakerTranslucent =
      Color.fromRGBO(156, 72, 184, 0.3);

  static const Color mindfulSelfBackground = Color.fromRGBO(53, 186, 106, 0.15);
  static const Color servantLeaderBackground =
      Color.fromRGBO(250, 143, 66, 0.15);
  static const Color compellingCommunicatorBackground =
      Color.fromRGBO(255, 176, 22, 0.15);
  static const Color criticalThinkerBackground =
      Color.fromRGBO(32, 118, 255, 0.15);
  static const Color creativeMakerBackground =
      Color.fromRGBO(156, 72, 184, 0.15);

  // methods
  static void bsRedirect() async {
    Uri url = Uri.http('besomeone.vip');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  static void discordRedirect() async {
    Uri url = Uri.http('discord.gg/yTX3aDYVFR');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not launch $url";
    }
  }

  static String image(String skill) {
    if (skill == 'Mindful Self') {
      return 'images/mindfulSelf.png';
    } else if (skill == 'Servant Leader') {
      return 'images/servantLeader.png';
    } else if (skill == 'Compelling Communicator') {
      return 'images/compellingCommunicator.png';
    } else if (skill == 'Critical Thinker') {
      return 'images/criticalThinker.png';
    } else if (skill == 'Creative Maker') {
      return 'images/creativeMaker.png';
    } else {
      return 'images/appLogo.jpg';
    }
  }

  static Color color(String skill) {
    if (skill == 'Mindful Self') {
      return Variables.mindfulSelf;
    } else if (skill == 'Servant Leader') {
      return Variables.servantLeader;
    } else if (skill == 'Compelling Communicator') {
      return Variables.compellingCommunicator;
    } else if (skill == 'Critical Thinker') {
      return Variables.criticalThinker;
    } else if (skill == 'Creative Maker') {
      return Variables.creativeMaker;
    } else {
      return Variables.teal;
    }
  }

  static Color colorTranslucent(String skill) {
    if (skill == 'Mindful Self') {
      return Variables.mindfulSelfTranslucent;
    } else if (skill == 'Servant Leader') {
      return Variables.servantLeaderTranslucent;
    } else if (skill == 'Compelling Communicator') {
      return Variables.compellingCommunicatorTranslucent;
    } else if (skill == 'Critical Thinker') {
      return Variables.criticalThinkerTranslucent;
    } else if (skill == 'Creative Maker') {
      return Variables.creativeMakerTranslucent;
    } else {
      return Variables.teal;
    }
  }

  static Color colorBackground(String skill) {
    if (skill == 'Mindful Self') {
      return Variables.mindfulSelfBackground;
    } else if (skill == 'Servant Leader') {
      return Variables.servantLeaderBackground;
    } else if (skill == 'Compelling Communicator') {
      return Variables.compellingCommunicatorBackground;
    } else if (skill == 'Critical Thinker') {
      return Variables.criticalThinkerBackground;
    } else if (skill == 'Creative Maker') {
      return Variables.creativeMakerBackground;
    } else {
      return Variables.teal;
    }
  }

  static Color subSkillColor(String subSkill) {
    if (Variables.skillsSP['Mindful Self']!.containsKey(subSkill)) {
      return color('Mindful Self');
    } else if (Variables.skillsSP['Servant Leader']!.containsKey(subSkill)) {
      return color('Servant Leader');
    } else if (Variables.skillsSP['Compelling Communicator']!
        .containsKey(subSkill)) {
      return color('Compelling Communicator');
    } else if (Variables.skillsSP['Critical Thinker']!.containsKey(subSkill)) {
      return color('Critical Thinker');
    } else if (Variables.skillsSP['Creative Maker']!.containsKey(subSkill)) {
      return color('Creative Maker');
    } else {
      return Variables.teal;
    }
  }

  static String description(String skill) {
    return Variables.skillDescriptions[skill] ?? '';
  }
}
