import 'package:best/desktop/desktop_login.dart';
import 'package:best/extensions/transitionless_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:best/global/variables.dart';

import '../extensions/responsive_layout.dart';
import '../global/mobile_message.dart';
import 'desktop_welcome.dart';

class DesktopCreateAccount extends StatefulWidget {
  const DesktopCreateAccount({Key? key}) : super(key: key);

  @override
  State<DesktopCreateAccount> createState() => DesktopCreateAccountState();
}

class DesktopCreateAccountState extends State<DesktopCreateAccount> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // create account method
  void _createAccount() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'The password provided is too weak.',
              ),
            );
          },
        );
        return;
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'The account already exists for that email.',
              ),
            );
          },
        );
        return;
      } else if (emailController.text == '') {
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
        return;
      }
    }
    _sendVerification();
  }

  // send email verification
  void _sendVerification() async {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text(
            'A verification has been sent to your email. Click\n'
            'the link to verify your account to be able to login.',
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
    firebaseAuth.authStateChanges().listen((User? user) async {
      Variables.user = user;
      if (user != null) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'UID': Variables.user!.uid,
          'Email': Variables.user!.email,
          'Verified': false,
          'Skills': Variables.skillsSP,
          'Juntos': ['open'],
        });
        FirebaseFirestore.instance.collection('users').doc(user.uid).collection('logs').doc('filler').set({
          'Time': 'Create your first log! The date of the log will show up here.',
          'Description': 'A list of all your logs will be here so you can keep track of your growth and reflect. '
          'This is where the description for each log will go.',
          'Skills': 'Each log also keeps track of the skills developed! The skills for each log will show up here.'
        });
        await Variables.user!.sendEmailVerification();
        dispose();
      }
    });
  }

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
                  // BLASC title
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
                  // password input
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.1,
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.1,
                    ),
                    width: (currentWidth * 0.4) * 0.7,
                    child: TextField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: passwordController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(),
                        labelText: 'Password',
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
                  // confirm password input
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.1,
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.1,
                    ),
                    width: (currentWidth * 0.4) * 0.7,
                    child: TextField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: confirmPasswordController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
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
                      ((currentHeight * 0.4) * 0.25) * 0.1,
                    ),
                    child: ElevatedButton(
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
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Text(
                                  'The passwords do not match.',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          );
                          return;
                        }
                        _createAccount();
                      },
                      child: Text(
                        'Create',
                        style: TextStyle(
                          fontSize: (currentHeight * 0.075) * 0.3,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      0,
                      (currentHeight * 0.4) * 0.25 * 0.1,
                      0,
                      (currentHeight * 0.4) * 0.25 * 0.2,
                    ),
                    child: InkWell(
                      onTap: () {
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
                        'Already have an account? Login',
                        style: TextStyle(
                          color: Variables.teal,
                          decoration: TextDecoration.underline,
                          fontSize: (currentHeight * 0.4) * 0.04,
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
