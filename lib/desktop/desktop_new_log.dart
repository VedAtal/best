import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../global/variables.dart';

class DesktopNewLog extends StatefulWidget {
  const DesktopNewLog({super.key});

  @override
  State<DesktopNewLog> createState() => _DesktopNewLogState();
}

class _DesktopNewLogState extends State<DesktopNewLog> {
  final descriptionController = TextEditingController();
  bool skillError = false;
  String? descriptionError;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    currentWidth * 0.2,
                    currentHeight * 0.05,
                    currentWidth * 0.2,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // exit button
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          currentWidth * 0.01,
                          currentHeight * 0.01,
                          currentWidth * 0.01,
                          currentHeight * 0.01,
                        ),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'Unsaved Changes',
                                    style: TextStyle(
                                      fontSize: currentWidth * 0.012,
                                    ),
                                  ),
                                  content: Text(
                                    'You have unsaved changes, are you sure you want to leave this page?',
                                    style: TextStyle(
                                      fontSize: currentWidth * 0.01,
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: currentWidth * 0.01,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        clearSubmission();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Variables.teal,
                                      ),
                                      child: Text(
                                        'Leave',
                                        style: TextStyle(
                                          fontSize: currentWidth * 0.01,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.close,
                            ),
                            iconSize: currentWidth * 0.025,
                            hoverColor: Colors.transparent,
                          ),
                        ),
                      ),
                      // description
                      Container(
                        margin: EdgeInsets.only(
                          bottom: currentHeight * 0.04,
                        ),
                        height: currentWidth * 0.13,
                        child: TextField(
                          controller: descriptionController,
                          maxLines: (currentHeight * 0.01).round(),
                          style: TextStyle(
                            fontSize: currentWidth * 0.008,
                          ),
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                              fontSize: currentWidth * 0.007,
                            ),
                            labelText: 'Log Description',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: const OutlineInputBorder(),
                            alignLabelWithHint: true,
                            errorText: descriptionError,
                          ),
                          maxLength: 500,
                          onChanged: (text) {
                            if (text.trim() != '') {
                              setState(() {
                                descriptionError = null;
                              });
                            }
                          },
                        ),
                      ),
                      // skills
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: skillError ? Colors.red : Colors.transparent,
                            width: 1,
                          ),
                        ),
                        margin: EdgeInsets.only(
                          bottom: currentHeight * 0.04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: currentHeight * 0.02,
                              ),
                              child: Text(
                                'Skills',
                                style: TextStyle(
                                  fontSize: currentWidth * 0.012,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ...(Variables.skillTopics).map((topic) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        skillTopicSelected[topic] =
                                            !skillTopicSelected[topic]!;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: currentHeight * 0.01,
                                      ),
                                      child: Row(
                                        children: [
                                          Transform.scale(
                                            scale: currentWidth * 0.0006,
                                            child: IconButton(
                                              icon: skillTopicSelected[topic]!
                                                  ? const Icon(Icons
                                                      .arrow_drop_down_sharp)
                                                  : const Icon(
                                                      Icons.arrow_right),
                                              onPressed: () {
                                                setState(() {
                                                  skillTopicSelected[topic] =
                                                      !skillTopicSelected[
                                                          topic]!;
                                                });
                                              },
                                              hoverColor: Colors.transparent,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: currentWidth * 0.007,
                                            ),
                                            child: Text(
                                              topic,
                                              style: TextStyle(
                                                fontSize: currentWidth * 0.01,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ...(Variables.skills[topic])!.map((skill) {
                                    if (skillTopicSelected[topic] == false) {
                                      return const SizedBox.shrink();
                                    } else {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            skillSelected[skill] =
                                                !skillSelected[skill]!;
                                            skillError = false;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: currentWidth * 0.01,
                                          ),
                                          height: currentWidth * 0.02,
                                          margin: EdgeInsets.only(
                                            bottom: currentHeight * 0.009,
                                          ),
                                          child: Row(
                                            children: [
                                              Transform.scale(
                                                scale: currentWidth * 0.0006,
                                                child: Checkbox(
                                                  hoverColor:
                                                      Colors.transparent,
                                                  value: skillSelected[skill],
                                                  onChanged: (checked) {
                                                    setState(() {
                                                      skillSelected[skill] =
                                                          checked!;
                                                      skillError = false;
                                                    });
                                                  },
                                                  activeColor: Variables.teal,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: currentWidth * 0.007,
                                                ),
                                                child: Text(
                                                  skill,
                                                  style: TextStyle(
                                                    fontSize:
                                                        currentWidth * 0.01,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                      // submit adventure
                      Container(
                        margin: EdgeInsets.only(
                          bottom: currentHeight * 0.04,
                        ),
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Variables.teal,
                          ),
                          child: Text(
                            'Track Log',
                            style: TextStyle(
                              fontSize: currentWidth * 0.015,
                            ),
                          ),
                          onPressed: () {
                            enterLog();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> enterLog() async {
    bool emptyFields = false;

    if (!skillSelected.containsValue(true)) {
      skillError = true;
      emptyFields = true;
    }

    if (descriptionController.text.isEmpty) {
      descriptionError = 'Can\'t be empty';
      emptyFields = true;
    }

    if (emptyFields) {
      setState(() {});
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
              'Some fields are empty.',
              textAlign: TextAlign.center,
            ),
          );
        },
      );
      return;
    }

    List<String> skills = [];

    skillSelected.forEach((key, value) {
      if (value == true) {
        skills.add(key);
      }
    });

    DateTime time = DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);

    FirebaseFirestore.instance
        .collection('users')
        .doc(Variables.user!.uid)
        .collection('logs')
        .add({
      'Time': '${monthConvert(time.month)} ${time.day}, ${time.year}',
      'Description': descriptionController.text.trim(),
      'Skills': skills,
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(Variables.user!.uid)
        .collection('logs')
        .doc('filler')
        .delete();

    clearSubmission();

    Navigator.pop(context);
  }

  void clearSubmission() {
    skillSelected.forEach((key, value) {
      skillSelected[key] = false;
    });

    skillTopicSelected.forEach((key, value) {
      skillTopicSelected[key] = false;
    });

    dispose();
  }

  String monthConvert(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        break;
    }
    return 'Month';
  }
}

var skillTopicSelected = {
  'Mindful Self': false,
  'Servant Leader': false,
  'Compelling Communicator': false,
  'Critical Thinker': false,
  'Creative Maker': false,
};

var skillSelected = {
  'Healthy Habits': false,
  'Growth Mindset': false,
  'Self-Direction': false,
  'Self-Reflection/Journaling': false,
  'Emotional Self-Regulation': false,
  'Good Judgement': false,
  'Confidence+Courage': false,
  'Cultivating Gratitude+Humility': false,
  'Curiosity+Imagination': false,
  'Wayfinding': false,
  'Individual Sport': false,
  'Warm-Hearted': false,
  'Tough-Minded': false,
  'Peer Support': false,
  'Conflict Resolution and Negotiation': false,
  'Citizenship': false,
  'Team Sport': false,
  'Collaborative Teamwork': false,
  'Community Volunteering': false,
  'Event Organizer or Volunteer': false,
  'Enterprising Entrepreneurship': false,
  'Zest+Humor': false,
  'Reading': false,
  'Spelling': false,
  'Grammar': false,
  'Vocabulary Expansion': false,
  'Keyboard/Typing': false,
  'Nonfiction Writing': false,
  'Fiction Writing': false,
  'Writing Feedback': false,
  'Multimedia': false,
  'Presenting': false,
  'Active Listening': false,
  'Foreign Language': false,
  'Math Problem Solving': false,
  'Socratic Dialogue/Debate': false,
  'Evidence Evaluation': false,
  'Textual Analysis': false,
  'Inquiry-Based Investigation': false,
  'Financial Literacy': false,
  'Coding+Algorithim Structuring': false,
  'Modeling+Simulations': false,
  'Decision Analysis': false,
  'Creative Problem-Solving Approaches': false,
  'Innovative Design Thinking': false,
  'Art': false,
  'Cooking': false,
  'Music': false,
  'Theater': false,
  'Video Creation': false,
  'Making': false,
  'Graphic Design+Animation': false,
  'Digital Design+Fabrication': false,
  'Engineering+Robotics': false,
};