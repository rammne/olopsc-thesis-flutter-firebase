import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  //sign up
  Future signUpWithEmailAndPassword(String email, String password,
      String full_name, String programLevel, String studentNumber) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      setSearchParam(String studentNumber) {
        List<String> caseSearchList = [];
        String temp = "";
        for (int i = 0; i < studentNumber.length; i++) {
          temp = temp + studentNumber[i];
          caseSearchList.add(temp);
        }
        return caseSearchList;
      }

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'full_name': full_name,
        'email': email,
        'program': programLevel,
        'student_number': studentNumber,
        'student_number_search': setSearchParam(studentNumber),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // sign out
  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  // verification
  Future sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  // send forgot password email
  Future sendForgotPasswordEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }
}
