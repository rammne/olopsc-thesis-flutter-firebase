import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool populated = false;
  String email = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Enter you OLOPSC gmail',
                style: TextStyle(color: Colors.blue[900]),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextFormField(
                  validator: (value) => value!.contains('@olopsc.edu.ph')
                      ? null
                      : 'OLOPSC gmail required (example@olopsc.edu.ph)',
                  onChanged: (value) {
                    setState(() {
                      if (email.isNotEmpty) {
                        populated = true;
                      } else {
                        populated = false;
                      }
                      email = value;
                    });
                  },
                  decoration: InputDecoration(),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: populated
                    ? () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          await _auth.sendForgotPasswordEmail(email);
                          final snackBar = SnackBar(
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 25),
                            content: Text('Email Sent!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    : null,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: populated ? Colors.blue[900] : Colors.blue[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
