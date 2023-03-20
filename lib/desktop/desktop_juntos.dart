import 'package:best/global/header_builder.dart';
import 'package:best/global/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DesktopJuntos extends StatefulWidget {
  const DesktopJuntos({super.key});

  @override
  State<DesktopJuntos> createState() => _DesktopJuntosState();
}

DateTime selectedDate = DateTime.now();

class _DesktopJuntosState extends State<DesktopJuntos> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(
        currentHeight,
        currentWidth,
        'Juntos',
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(
          currentWidth * 0.025,
          currentHeight * 0.025,
          currentWidth * 0.025,
          currentHeight * 0.025,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(currentWidth * 0.02),
              width: currentWidth * 0.45,
              height: currentHeight * 0.85,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.5,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  selected(currentHeight, currentWidth, 'Talent'),
                  selected(currentHeight, currentWidth, 'Topic'),
                  selected(currentHeight, currentWidth, 'HNLB'),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(currentWidth * 0.02),
              width: currentWidth * 0.45,
              height: currentHeight * 0.85,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.5,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CalendarWidget(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: currentWidth * 0.01),
                          child: Text(
                            'Add a new Junto:',
                            style: TextStyle(
                              fontSize: currentWidth * 0.012,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: currentHeight * 0.05,
                          width: currentWidth * 0.2,
                          child: TextField(
                            controller: codeController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Code',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Variables.teal,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: currentWidth * 0.01),
                          child: ElevatedButton(
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
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontSize: currentWidth * 0.012,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime selectedDate;
  late DateTime focusedDate;
  CalendarFormat calendarFormat = CalendarFormat.month;
  Map<DateTime, List<String>> events = {};

  final Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance
      .collection('users')
      // .doc(Variables.user!.uid)
      .doc('WufjOBYoaDhe2RfjGoHf3v3uhzs1')
      .snapshots();

  List<String> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  bool isSameDay(DateTime selected, DateTime day) {
    return selected == day;
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    focusedDate = DateTime.now();
    super.initState();
    events = {};
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: documentStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

        List<dynamic> juntoCodes = snapshot.data!['Juntos'];

        Map<String, String> juntosList = {};

        for (int i = 0; i < juntoCodes.length; i++) {
          FirebaseFirestore.instance
              .collection('juntos')
              .doc(juntoCodes[i])
              .get()
              .then(
            (doc) {
              doc.data()!['info'].forEach((key, value) {
                juntosList.addEntries({key as String: value as String}.entries);
              });
            },
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Date: ${DateFormat('MMMM d, y').format(selectedDate)}',
              style: TextStyle(
                fontSize: currentWidth * 0.015,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: currentHeight * 0.02),
            TableCalendar(
              rowHeight: currentHeight * 0.075,
              focusedDay: focusedDate,
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 1, 11),
              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDate = selected;
                  focusedDate = focused;
                });
              },
              onPageChanged: (focused) {
                focusedDate = focused;
              },
              eventLoader: (day) {
                if (day.weekday == DateTime.tuesday) {
                  events.addEntries({
                    day: ['Weekly Open Junto Meeting: 7:00 PM EST']
                  }.entries);
                }
                return getEventsForDay(day);
              },
              calendarFormat: calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  calendarFormat = format;
                });
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        fontSize: currentWidth * 0.012,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: currentHeight * 0.02),
            ...getEventsForDay(selectedDate).map(
              (event) {
                return Text(
                  event,
                  style: TextStyle(
                    fontSize: currentWidth * 0.014,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

Widget selected(double currentHeight, double currentWidth, String section) {
  final Stream<DocumentSnapshot> documentStream =
      FirebaseFirestore.instance.collection('otw').doc('selected').snapshots();

  return StreamBuilder(
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

      String title = '';
      String description = '';

      snapshot.data![section.toLowerCase()].forEach((key, value) {
        title = key;
        description = value;
      });

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$section of the Week:',
            style: TextStyle(
              fontSize: currentWidth * 0.02,
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: currentWidth * 0.02,
              color: Variables.teal,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: currentWidth * 0.012,
            ),
          ),
        ],
      );
    },
  );
}
