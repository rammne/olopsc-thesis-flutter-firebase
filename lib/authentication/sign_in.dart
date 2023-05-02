import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication/sign_up.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/shared/loading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../constants/shared.dart';
import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();
  // states
  String email = '';
  String password = '';
  String error = '';
  bool populated = false;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void _showSignUp() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.blue[100],
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return SignUp();
        },
      );
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LayoutBuilder(
        builder: (context, constraint) {
          // tablet
          if (constraint.maxWidth > 600) {
            return Form(
              key: _formKey,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Image.asset(
                            'lib/images/olopsc.png',
                            scale: 3,
                          ),
                          SizedBox(
                            height: 480,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                  if (email.isNotEmpty && email.isNotEmpty) {
                                    populated = true;
                                  } else {
                                    populated = false;
                                  }
                                });
                              },
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter something' : null,
                              decoration: textInputDecoration.copyWith(
                                hintText: 'OLOPSC Email',
                                floatingLabelStyle:
                                    TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                  if (password.isNotEmpty &&
                                      password.isNotEmpty) {
                                    populated = true;
                                  } else {
                                    populated = false;
                                  }
                                });
                              },
                              validator: (value) => value!.length < 6
                                  ? 'Password should be +6 chars long'
                                  : null,
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(
                                hintText: 'Password',
                                floatingLabelStyle:
                                    TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 70),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       TextButton(
                          //         onPressed: () {},
                          //         child: Text(
                          //           'Forgot Password?',
                          //           style: TextStyle(
                          //             color: Color(Colors.blue.shade900.value),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: populated
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error = 'Invalid sign in';
                                        });
                                      }
                                    }
                                  }
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                  color: populated
                                      ? Colors.blue[900]
                                      : Colors.blue[200],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            '${error}',
                            style: TextStyle(color: Colors.red),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextButton(
                                    onPressed: () => _showSignUp(),
                                    child: Text(
                                      'Create an Account?',
                                      style: TextStyle(
                                        color:
                                            Color(Colors.blue.shade900.value),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color:
                                            Color(Colors.blue.shade900.value),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
          // mobile
          if (constraint.maxWidth <= 600) {
            return Form(
              key: _formKey,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Image.asset(
                            'lib/images/olopsc.png',
                            scale: 5,
                          ),
                          SizedBox(
                            height: 300,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                  if (email.isNotEmpty && email.isNotEmpty) {
                                    populated = true;
                                  } else {
                                    populated = false;
                                  }
                                });
                              },
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter something' : null,
                              decoration: textInputDecoration.copyWith(
                                hintText: 'OLOPSC Email',
                                floatingLabelStyle:
                                    TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                  if (password.isNotEmpty &&
                                      password.isNotEmpty) {
                                    populated = true;
                                  } else {
                                    populated = false;
                                  }
                                });
                              },
                              validator: (value) => value!.length < 6
                                  ? 'Password should be +6 chars long'
                                  : null,
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(
                                hintText: 'Password',
                                floatingLabelStyle:
                                    TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 70),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       TextButton(
                          //         onPressed: () {},
                          //         child: Text(
                          //           'Forgot Password?',
                          //           style: TextStyle(
                          //             color: Color(Colors.blue.shade900.value),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: populated
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      if (result == null) {
                                        setState(() {
                                          error = 'Invalid sign in';
                                        });
                                      }
                                    }
                                  }
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                  color: populated
                                      ? Colors.blue[900]
                                      : Colors.blue[200],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            '${error}',
                            style: TextStyle(color: Colors.red),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextButton(
                                    onPressed: () => _showSignUp(),
                                    child: Text(
                                      'Create an Account?',
                                      style: TextStyle(
                                        color:
                                            Color(Colors.blue.shade900.value),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        color:
                                            Color(Colors.blue.shade900.value),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
          return Loading();
        },
      ),
    );
  }
}
