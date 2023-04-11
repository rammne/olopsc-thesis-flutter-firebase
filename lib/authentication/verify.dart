import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/home.dart';
import 'package:flutter_application_1/services/auth.dart';

import '../responsive/desktop_responsive.dart';
import '../responsive/mobile_responsive.dart';
import '../responsive/responsive_layout.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  Timer? timer;
  bool isEmailVerified = false;
  AuthService _auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      _auth.sendVerificationEmail();
      timer = Timer.periodic(
          Duration(seconds: 3), (_) => _checkEmailVerification());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  Future _checkEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? Home()
        : Scaffold(
            body: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Verification sent to your email',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        await _auth.sendVerificationEmail();
                      },
                      icon: Icon(Icons.email),
                      label: Text(
                        'Resend Verification',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      icon: Icon(Icons.logout),
                      label: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
