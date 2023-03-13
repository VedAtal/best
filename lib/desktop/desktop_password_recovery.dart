import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../extensions/responsive_layout.dart';
import '../extensions/transitionless_route.dart';
import '../global/Variables.dart';
import '../global/mobile_message.dart';
import 'desktop_welcome.dart';

class DesktopPasswordRecovery extends StatefulWidget {
  const DesktopPasswordRecovery({Key? key}) : super(key: key);

  @override
  State<DesktopPasswordRecovery> createState() =>
      _DesktopPasswordRecoveryState();
}

class _DesktopPasswordRecoveryState extends State<DesktopPasswordRecovery> {
  Future<void> resetPassword(String email) async {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text(
            'A password recovery has been sent to your email. Click\n'
            'the link to change your password to be able to login.',
            textAlign: TextAlign.center,
          ),
        );
      },
    ).then((value) => Navigator.of(context).push(
          TransitionlessRoute(
            builder: (context) => const ResponsiveLayout(
              DesktopWelcome(),
              MobileMessage(),
            ),
          ),
        ));
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                child: InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).push(
                      TransitionlessRoute(
                        builder: (context) => const ResponsiveLayout(
                          DesktopWelcome(),
                          MobileMessage(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'BeST',
                    style: TextStyle(
                      color: Variables.teal,
                      fontSize: (currentHeight * 0.075) * 0.5,
                    ),
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
                ],
              ),
            )
          ],
        ),
      ),
      body: Container(
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
          child: FittedBox(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black87,
              ),
              child: Column(
                children: [
                  // BeST title
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.1,
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.1,
                    ),
                    child: Text(
                      'BeST',
                      style: TextStyle(
                        color: Variables.teal,
                        fontSize: (currentHeight * 0.4) * 0.17,
                      ),
                    ),
                  ),
                  // email input
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.1,
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.1,
                    ),
                    width: (currentWidth * 0.4) * 0.7,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // create button
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.15,
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.2,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Variables.teal,
                        minimumSize: Size(
                          (currentWidth * 0.05),
                          (currentHeight * 0.075) * 0.6,
                        ),
                        maximumSize: Size(
                          (currentWidth * 0.1),
                          (currentHeight * 0.075) * 0.6,
                        ),
                      ),
                      onPressed: () {
                        if (emailController.text.trim() == '') {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text(
                                  'Email cannot be blank.',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          );
                        } else {
                          resetPassword(emailController.text.trim());
                        }
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: (currentHeight * 0.075) * 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
