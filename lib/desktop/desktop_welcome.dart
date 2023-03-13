import 'package:best/desktop/desktop_create_account.dart';
import 'package:best/desktop/desktop_login.dart';
import 'package:best/extensions/transitionless_route.dart';
import 'package:best/global/mobile_message.dart';
import 'package:best/global/variables.dart';
import 'package:flutter/material.dart';

import '../extensions/popup_route.dart';
import '../extensions/responsive_layout.dart';

class DesktopWelcome extends StatelessWidget {
  const DesktopWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     children: [
      //       Container(
      //         child: Image.asset('images/appLogo.jpg'),
      //       ),
      //       Container(
      //         child: Text('© 2022 Talent Unbound PBC, All Rights Reserved'),
      //       ),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: currentHeight * 0.075,
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // BeST title
            Container(
              margin: EdgeInsets.only(left: currentWidth * 0.02),
              height: (currentHeight * 0.075) * 0.9,
              child: Center(
                child: Text(
                  'BeST',
                  style: TextStyle(
                    color: Variables.teal,
                    fontSize: (currentHeight * 0.075) * 0.5,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: currentWidth * 0.02),
              height: (currentHeight * 0.075) * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // app logo
                  Container(
                    margin: EdgeInsets.only(right: currentWidth * 0.01),
                    child: InkWell(
                      onTap: () {
                        Variables.bsRedirect();
                      },
                      child: Image.asset(
                        'images/appLogo.jpg',
                        height: (currentHeight * 0.075) * 0.7,
                      ),
                    ),
                  ),
                  // login button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Variables.teal,
                      minimumSize: Size(
                        (currentWidth * 0.05),
                        (currentHeight * 0.075) * 0.6,
                      ),
                      maximumSize: Size(
                        (currentWidth * 0.2),
                        (currentHeight * 0.075) * 0.6,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        TransitionlessRoute(
                          builder: (context) => const ResponsiveLayout(
                            DesktopLogin(),
                            MobileMessage(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: (currentHeight * 0.075) * 0.30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        currentHeight * 0.28,
                        0,
                        currentHeight * 0.28,
                      ),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/talentGraphic.png'),
                          opacity: 0.74,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: currentHeight * 0.04),
                              child: Text(
                                'Making ourselves better\nto make the world better.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: currentWidth * 0.028,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Variables.translucentGold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Variables.teal,
                                minimumSize: Size(
                                  (currentWidth * 0.05),
                                  (currentHeight * 0.06),
                                ),
                                maximumSize: Size(
                                  (currentWidth * 0.2),
                                  (currentHeight * 0.06),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  PopUpRoute(
                                    builder: (context) =>
                                        const ResponsiveLayout(
                                      DesktopCreateAccount(),
                                      MobileMessage(),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: currentWidth * 0.015,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(thickness: 5),
                    card(
                      currentWidth,
                      currentHeight,
                      'Track you growth.',
                      'Track your skills from our \"Big 5 Talents\": Mindful Self, Servant Leader, '
                          'Compelling Communicator, Critical Thinker & Problem Solver, and Creative Maker '
                          'and their 54 subset skills! Develop real world skills in the process impressive '
                          'to colleges and future employers.',
                      'images/appLogo.jpg',
                      true,
                    ),
                    const Divider(thickness: 5),
                    card(
                      currentWidth,
                      currentHeight,
                      'Explore Juntos.',
                      'Founded by Master Inventor, Founding Father, and a Pioneer of Self-Improvement, '
                          'Benjamin Franklin, we\'re bringing Juntos back with a 21st-Century twist. Connect '
                          'with like-minded peers who want to take charge of their future, develop cool '
                          'talent, and make a meaningful contribution to the world.',
                      'images/appLogo.jpg',
                      false,
                    ),
                    const Divider(thickness: 5),
                    card(
                      currentWidth,
                      currentHeight,
                      'Share your achievements.',
                      'Keep a log of past activites with date, description, and skills developed to relfect '
                          'on and see your progress. Export the log of your developments to share with friends, '
                          'family, and future employers to demonstrate your skills.',
                      'images/appLogo.jpg',
                      true,
                    ),
                    const Divider(thickness: 5),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        currentWidth * 0.2,
                        currentHeight * 0.12,
                        currentWidth * 0.2,
                        currentHeight * 0.1,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: currentHeight * 0.03),
                              child: Text(
                                'Start your journey today\nand Be Someone!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: currentWidth * 0.03,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Variables.teal,
                                minimumSize: Size(
                                  (currentWidth * 0.05),
                                  (currentHeight * 0.06),
                                ),
                                maximumSize: Size(
                                  (currentWidth * 0.2),
                                  (currentHeight * 0.06),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  PopUpRoute(
                                    builder: (context) =>
                                        const ResponsiveLayout(
                                      DesktopCreateAccount(),
                                      MobileMessage(),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: currentWidth * 0.015,
                                ),
                              ),
                            ),
                          ],
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

  Widget card(double currentWidth, double currentHeight, String title,
      String description, String image, bool left) {
    var widgets = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: currentWidth * 0.02,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          Container(
            margin: EdgeInsets.only(
              top: currentHeight * 0.01,
            ),
            width: currentWidth * 0.36,
            child: Text(
              description,
              style: TextStyle(
                fontSize: currentWidth * 0.013,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      Image.asset(
        image,
        height: currentWidth * 0.15,
      )
    ];

    return Container(
      margin: EdgeInsets.fromLTRB(
        currentWidth * 0.2,
        currentHeight * 0.06,
        currentWidth * 0.2,
        currentHeight * 0.06,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          left ? widgets[0] : widgets[1],
          left ? widgets[1] : widgets[0],
        ],
      ),
    );
  }
}
