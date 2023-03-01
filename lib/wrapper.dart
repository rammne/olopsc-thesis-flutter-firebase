import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication/sign_in.dart';
import 'package:flutter_application_1/authentication/verify.dart';
import 'package:flutter_application_1/responsive/desktop_responsive.dart';
import 'package:flutter_application_1/responsive/mobile_responsive.dart';
import 'package:flutter_application_1/responsive/responsive_layout.dart';
import 'package:flutter_application_1/responsive/tablet_responsive.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Verification();
        } else {
          return SignIn();
        }
      },
    );
  }
}
