import 'package:best/desktop/desktop_create_account.dart';
import 'package:best/extensions/transitionless_route.dart';
import 'package:best/global/mobile_message.dart';
import 'package:best/global/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../extensions/popup_route.dart';
import '../extensions/responsive_layout.dart';

// class DesktopLogin extends StatefulWidget {
//   const DesktopLogin({super.key});

//   @override
//   State<DesktopLogin> createState() => _DesktopLoginState();
// }

// class _DesktopLoginState extends State<DesktopLogin> {
//   @override
//   Widget build(BuildContext context) {
//     final currentWidth = MediaQuery.of(context).size.width;
//     final currentHeight = MediaQuery.of(context).size.height;

//     return Container(

//     );
//   }
// }

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
        Navigator.push(
          context,
          TransitionlessRoute(
            builder: (context) => const ResponsiveLayout(
              MobileMessage(),
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

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: currentWidth * 0.01,
          )
        ],
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
      ),
      margin: EdgeInsets.fromLTRB(
        currentWidth * 0.3,
        currentHeight * 0.3,
        currentWidth * 0.3,
        currentHeight * 0.3,
      ),
      child: Material(
        child: Center(
          child: FittedBox(
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
                      border: OutlineInputBorder(),
                      labelText: 'Email',
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
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
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
                        (currentHeight * 0.4) * 0.25 * 0.15,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PopUpRoute(
                              builder: (context) => const ResponsiveLayout(
                                MobileMessage(),
                                MobileMessage(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.blue,
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
                        (currentHeight * 0.4) * 0.25 * 0.15,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
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
                            color: Colors.blue,
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
    );
  }
}