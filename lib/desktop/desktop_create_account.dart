import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:best/global/Variables.dart';

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
    ).then((value) => Navigator.pop(context));
    firebaseAuth.authStateChanges().listen((User? user) async {
      Variables.user = user;
      if (user != null) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'UID': Variables.user!.uid,
          'Email': Variables.user!.email,
          'Verified': false,
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
                    obscureText: true,
                    obscuringCharacter: '*',
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
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
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
