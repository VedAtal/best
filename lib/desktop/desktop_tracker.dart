import 'package:best/desktop/desktop_new_log.dart';
import 'package:best/global/header_builder.dart';
import 'package:best/global/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../extensions/responsive_layout.dart';
import '../extensions/transitionless_route.dart';
import '../global/mobile_message.dart';

class DesktopTracker extends StatefulWidget {
  const DesktopTracker({super.key});

  @override
  State<DesktopTracker> createState() => _DesktopTrackerState();
}

String selectedSkill = 'Mindful Self';

class _DesktopTrackerState extends State<DesktopTracker> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(
        currentHeight,
        currentWidth,
        'Tracker',
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(
          currentWidth * 0.025,
          currentHeight * 0.025,
          currentWidth * 0.025,
          currentHeight * 0.025,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: currentHeight * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child:
                        skillCard(currentHeight, currentWidth, 'Mindful Self'),
                    onTap: () {
                      setState(() {
                        selectedSkill = 'Mindful Self';
                      });
                    },
                  ),
                  InkWell(
                    child: skillCard(
                        currentHeight, currentWidth, 'Servant Leader'),
                    onTap: () {
                      setState(() {
                        selectedSkill = 'Servant Leader';
                      });
                    },
                  ),
                  InkWell(
                    child: skillCard(
                        currentHeight, currentWidth, 'Compelling Communicator'),
                    onTap: () {
                      setState(() {
                        selectedSkill = 'Compelling Communicator';
                      });
                    },
                  ),
                  InkWell(
                    child: skillCard(
                        currentHeight, currentWidth, 'Critical Thinker'),
                    onTap: () {
                      setState(() {
                        selectedSkill = 'Critical Thinker';
                      });
                    },
                  ),
                  InkWell(
                    child: skillCard(
                        currentHeight, currentWidth, 'Creative Maker'),
                    onTap: () {
                      setState(() {
                        selectedSkill = 'Creative Maker';
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(currentWidth * 0.01),
                  width: currentWidth * 0.35,
                  height: currentHeight * 0.68,
                  decoration: BoxDecoration(
                    color: Variables.colorBackground(selectedSkill),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: skillInfo(currentHeight, currentWidth),
                ),
                Container(
                  padding: EdgeInsets.all(currentWidth * 0.015),
                  width: currentWidth * 0.58,
                  height: currentHeight * 0.68,
                  decoration: BoxDecoration(
                    // color: colorBackground(selectedSkill),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Log',
                                  style: TextStyle(
                                    fontSize: currentWidth * 0.017,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Variables.teal,
                                    minimumSize: Size(
                                      (currentWidth * 0.05),
                                      (currentHeight * 0.075) * 0.55,
                                    ),
                                    maximumSize: Size(
                                      (currentWidth * 0.2),
                                      (currentHeight * 0.075) * 0.55,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      TransitionlessRoute(
                                        builder: (context) =>
                                            const ResponsiveLayout(
                                          DesktopNewLog(),
                                          MobileMessage(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'New',
                                    style: TextStyle(
                                      fontSize: currentWidth * 0.012,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trackerLogs(currentHeight, currentWidth),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget trackerLogs(double currentHeight, double currentWidth) {
  final Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance
      .collection('users')
      // .doc(Variables.user!.uid)
      .doc('WufjOBYoaDhe2RfjGoHf3v3uhzs1')
      .collection('logs')
      .orderBy('Time', descending: true)
      .snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: documentStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox(
          child: Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

          List<TextSpan> skills = <TextSpan>[];
          for (int i = 0; i < data['Skills'].length; i++) {
            skills.add(
              TextSpan(
                text: data['Skills'][i] + '       ',
                style: TextStyle(
                  fontSize: currentWidth * 0.010,
                  color: Variables.subSkillColor(data['Skills'][i]),
                ),
              ),
            );
          }

          return Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(currentWidth * 0.01),
            margin: EdgeInsets.only(top: currentHeight * 0.025),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: currentHeight * 0.007),
                  child: Text(
                    data['Time'],
                    style: TextStyle(
                      fontSize: currentWidth * 0.014,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: currentHeight * 0.007),
                  child: Text(
                    data['Description'],
                    style: TextStyle(
                      fontSize: currentWidth * 0.010,
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '',
                    style: TextStyle(
                      fontSize: currentWidth * 0.012,
                    ),
                    children: skills,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    },
  );
}

Widget skillInfo(double currentHeight, double currentWidth) {
  final Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance
      .collection('users')
      // .doc(Variables.user!.uid)
      .doc('WufjOBYoaDhe2RfjGoHf3v3uhzs1')
      .snapshots();

  return StreamBuilder<DocumentSnapshot>(
    stream: documentStream,
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox(
          child: Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          ),
        );
      }

      List<Widget> skills = [];
      int count = 0;

      snapshot.data!['Skills'][selectedSkill]!.forEach(
        (key, value) {
          skills.add(
            RichText(
              text: TextSpan(
                text: '$key: ',
                style: TextStyle(
                  fontSize: currentWidth * 0.012,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '$value SP',
                    style: TextStyle(
                      color: Variables.color(selectedSkill),
                      fontSize: currentWidth * 0.012,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
          );
          count += value as int;
        },
      );

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: currentWidth * 0.02),
                child: Image.asset(
                  Variables.image(selectedSkill),
                  height: currentWidth * 0.05,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FittedBox(
                    child: Text(
                      selectedSkill,
                      style: TextStyle(
                        fontSize: currentWidth * 0.018,
                        color: Variables.color(selectedSkill),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Level ${(count / 100).floor()}           ',
                      style: TextStyle(
                          fontSize: currentWidth * 0.012,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${count % 100} SP',
                          style: TextStyle(
                            color: Variables.color(selectedSkill),
                            fontSize: currentWidth * 0.012,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (currentWidth * 0.35) * 0.40,
                    child: LinearProgressIndicator(
                      value: count % 100 / 100,
                      color: Variables.color(selectedSkill),
                      backgroundColor: Variables.colorTranslucent(selectedSkill),
                      minHeight: 7,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ...skills,
        ],
      );
    },
  );
}

Widget skillCard(double currentHeight, double currentWidth, String skill) {
  final Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance
      .collection('users')
      // .doc(Variables.user!.uid)
      .doc('WufjOBYoaDhe2RfjGoHf3v3uhzs1')
      .snapshots();

  return StreamBuilder<DocumentSnapshot>(
    stream: documentStream,
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SizedBox(
          child: Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          ),
        );
      }

      List<String> skillSplit = skill.split(' ');

      return Container(
        padding: EdgeInsets.all(currentWidth * 0.005),
        decoration: BoxDecoration(
          color: skill == selectedSkill ? Variables.colorBackground(skill) : null,
          border: Border.all(
            color: Variables.color(skill),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        width: (currentWidth * 0.95) * 0.17,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              Variables.image(skill),
              height: currentWidth * 0.038,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  child: Text(
                    '${skillSplit[0]}\n${skillSplit[1]}',
                    style: TextStyle(
                      fontSize: currentWidth * 0.012,
                      color: Variables.color(skill),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}