import 'package:best/desktop/desktop_login.dart';
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
      appBar: AppBar(
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
                      Navigator.push(
                        context,
                        PopUpRoute(
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    currentWidth * 0.2,
                    currentHeight * 0.1,
                    currentWidth * 0.2,
                    0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Title',
                                    style: TextStyle(
                                      fontSize: currentWidth * 0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: currentHeight * 0.002,
                                    ),
                                    width: currentWidth * 0.36,
                                    child: Text(
                                      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, '
                                      'molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum '
                                      'numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium '
                                      'optio, eaque rerum!',
                                      style: TextStyle(
                                        fontSize: currentWidth * 0.013,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'images/appLogo.jpg',
                                height: currentWidth * 0.15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(),
                      Container(),
                      Container(),
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
}
