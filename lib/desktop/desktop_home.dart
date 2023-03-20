import 'package:best/global/header_builder.dart';
import 'package:flutter/material.dart';

import '../extensions/popup_route.dart';
import '../extensions/responsive_layout.dart';
import '../global/mobile_message.dart';
import '../global/variables.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

String selectedSkill = '';

class _DesktopHomeState extends State<DesktopHome> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(
        currentHeight,
        currentWidth,
        'Home',
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: currentHeight * 0.15,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/homepageTop.png'),
                          opacity: 1.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: currentHeight * 0.01,
                      ),
                      child: Text(
                        'Skills',
                        style: TextStyle(
                          fontSize: currentWidth * 0.02,
                          color: Variables.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: EdgeInsets.fromLTRB(
                        currentWidth * 0.01,
                        currentHeight * 0.0,
                        currentWidth * 0.01,
                        currentHeight * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...(Variables.skillTopics).map((topic) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: currentWidth * 0.0008,
                                      child: IconButton(
                                        icon: skillTopicSelected[topic]!
                                            ? const Icon(
                                                Icons.arrow_drop_down_sharp)
                                            : const Icon(Icons.arrow_right),
                                        onPressed: () {
                                          setState(() {
                                            skillTopicSelected[topic] =
                                                !skillTopicSelected[topic]!;
                                          });
                                        },
                                        hoverColor: Colors.transparent,
                                      ),
                                    ),
                                    InkWell(
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        selectedSkill = topic;
                                        Navigator.push(
                                          context,
                                          PopUpRoute(
                                            builder: (context) =>
                                                const ResponsiveLayout(
                                              TalentDescription(),
                                              MobileMessage(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          left: currentWidth * 0.007,
                                        ),
                                        child: Text(
                                          topic,
                                          style: TextStyle(
                                            fontSize: currentWidth * 0.010,
                                            fontWeight: FontWeight.bold,
                                            color: Variables.color(topic),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ...(Variables.skills[topic])!.map((skill) {
                                  if (skillTopicSelected[topic] == false) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return Container(
                                      padding: EdgeInsets.only(
                                        left: currentWidth * 0.01,
                                      ),
                                      margin: EdgeInsets.only(
                                        bottom: currentHeight * 0.022,
                                      ),
                                      child: InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: () {
                                          selectedSkill = skill;
                                          Navigator.push(
                                            context,
                                            PopUpRoute(
                                              builder: (context) =>
                                                  const ResponsiveLayout(
                                                SkillDescription(),
                                                MobileMessage(),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          skill,
                                          style: TextStyle(
                                            fontSize: currentWidth * 0.009,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }).toList(),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: currentHeight * 0.01,
                      ),
                      child: Text(
                        'Juntos',
                        style: TextStyle(
                          fontSize: currentWidth * 0.02,
                          color: Variables.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        currentWidth * 0.05,
                        0,
                        currentWidth * 0.05,
                        0,
                      ),
                      child: Text(
                        'Meaning, "together" in Spanish, a junto is a mutual improvement society historically '
                        'founded by Benjamin Franklin. We\'re bringing them back for students with some 21st-century '
                        'upgrades!\n\nOnce a week you will meet online through Discord with two trained facilitators and '
                        '5~10 other students for around 90 minutes.\n\nEach session will include check-ins, topics from '
                        'the How to Navigate Life book, self-improvement discussions based on the five talents, topic '
                        'dialogues, and closing reflections with goal setting - all within a safe, confidential, and '
                        'caring environment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: currentWidth * 0.012,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        currentWidth * 0.2,
                        currentHeight * 0.12,
                        currentWidth * 0.2,
                        currentHeight * 0.01,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: currentHeight * 0.03),
                              child: Text(
                                'Join the discord and start your growth!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: currentWidth * 0.015,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Variables.teal,
                                minimumSize: Size(
                                  (currentWidth * 0.05),
                                  (currentHeight * 0.04),
                                ),
                                maximumSize: Size(
                                  (currentWidth * 0.2),
                                  (currentHeight * 0.05),
                                ),
                              ),
                              onPressed: () {
                                Variables.discordRedirect();
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: currentWidth * 0.012,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: currentHeight * 0.15,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/homepageBottom.png'),
                          opacity: 1.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TalentDescription extends StatefulWidget {
  const TalentDescription({super.key});

  @override
  State<TalentDescription> createState() => _TalentDescriptionState();
}

class _TalentDescriptionState extends State<TalentDescription> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Variables.color(selectedSkill),
            blurRadius: 25,
          ),
        ],
        border: Border.all(
          color: Colors.black,
          width: currentWidth * 0.002,
        ),
      ),
      margin: EdgeInsets.fromLTRB(
        currentWidth * 0.30,
        currentHeight * 0.30,
        currentWidth * 0.30,
        currentHeight * 0.30,
      ),
      child: Material(
        child: Container(
          padding: EdgeInsets.fromLTRB(
            currentWidth * 0.05,
            currentHeight * 0.05,
            currentWidth * 0.05,
            currentHeight * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                selectedSkill,
                style: TextStyle(
                  fontSize: currentWidth * 0.018,
                  color: Variables.color(selectedSkill),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: currentHeight * 0.02),
              Text(
                Variables.description(selectedSkill),
                style: TextStyle(
                  fontSize: currentWidth * 0.014,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkillDescription extends StatefulWidget {
  const SkillDescription({super.key});

  @override
  State<SkillDescription> createState() => _SkillDescriptionState();
}

class _SkillDescriptionState extends State<SkillDescription> {
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Variables.subSkillColor(selectedSkill),
            blurRadius: 25,
          ),
        ],
        border: Border.all(
          color: Colors.black,
          width: currentWidth * 0.002,
        ),
      ),
      margin: EdgeInsets.fromLTRB(
        currentWidth * 0.30,
        currentHeight * 0.30,
        currentWidth * 0.30,
        currentHeight * 0.30,
      ),
      child: Material(
        child: Container(
          padding: EdgeInsets.fromLTRB(
            currentWidth * 0.05,
            currentHeight * 0.05,
            currentWidth * 0.05,
            currentHeight * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                selectedSkill,
                style: TextStyle(
                  fontSize: currentWidth * 0.015,
                  color: Variables.subSkillColor(selectedSkill),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: currentHeight * 0.02),
              Text(
                Variables.description(selectedSkill),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: currentWidth * 0.0125,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var skillTopicSelected = {
  'Mindful Self': true,
  'Servant Leader': true,
  'Compelling Communicator': true,
  'Critical Thinker': true,
  'Creative Maker': true,
};
