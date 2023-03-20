import 'package:best/extensions/transitionless_route.dart';
import 'package:best/global/mobile_message.dart';
import 'package:best/global/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../extensions/popup_route.dart';
import '../extensions/responsive_layout.dart';
import 'desktop_create_account.dart';
import 'desktop_home.dart';
import 'desktop_password_recovery.dart';
import 'desktop_welcome.dart';

class DesktopLogin extends StatefulWidget {
  const DesktopLogin({Key? key}) : super(key: key);

  @override
  State<DesktopLogin> createState() => DesktopLoginState();
}

class DesktopLoginState extends State<DesktopLogin> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // sing in method
  void _signIn() async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'No user found for that email.',
              ),
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'Wrong password provided for that user.',
              ),
            );
          },
        );
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
      }
    }
  }

  // check if user is logged in
  void _verifyCredentials() {
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        if (!user.emailVerified) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text(
                  'That email has not been verified.',
                ),
              );
            },
          );
          return;
        }
        Variables.user = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance
            .collection('users')
            .doc(Variables.user!.uid)
            .update({
          'Verified': true,
        });
        dispose();

        Navigator.of(context).pushReplacement(
          TransitionlessRoute(
            builder: (context) => const ResponsiveLayout(
              DesktopHome(),
              MobileMessage(),
            ),
          ),
        );
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
                      obscureText: hidePassword,
                      obscuringCharacter: '*',
                      controller: passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  // login button
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.15,
                      ((currentWidth * 0.4) * 0.7) * 0.1,
                      ((currentHeight * 0.4) * 0.25) * 0.07,
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
                        _signIn();
                        _verifyCredentials();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: (currentHeight * 0.075) * 0.3,
                        ),
                      ),
                    ),
                  ),
                  // forgot password and create account
                  Row(
                    children: [
                      // forgot password
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          (currentWidth * 0.4) * 0.6 * 0.1,
                          (currentHeight * 0.4) * 0.25 * 0.15,
                          (currentWidth * 0.4) * 0.6 * 0.15,
                          (currentHeight * 0.4) * 0.25 * 0.2,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              TransitionlessRoute(
                                builder: (context) => const ResponsiveLayout(
                                  DesktopPasswordRecovery(),
                                  MobileMessage(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Variables.teal,
                              decoration: TextDecoration.underline,
                              fontSize: (currentHeight * 0.4) * 0.04,
                            ),
                          ),
                        ),
                      ),
                      // create account
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          (currentWidth * 0.4) * 0.6 * 0.15,
                          (currentHeight * 0.4) * 0.25 * 0.15,
                          (currentWidth * 0.4) * 0.6 * 0.1,
                          (currentHeight * 0.4) * 0.25 * 0.2,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PopUpRoute(
                                builder: (context) => const ResponsiveLayout(
                                  DesktopCreateAccount(),
                                  MobileMessage(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Create Account',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
