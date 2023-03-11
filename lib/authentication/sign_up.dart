import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/shared/loading.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  var items = [
    'Tourism 1st',
    'Tourism 2nd',
    'Tourism 3rd',
    'Tourism 4th',
    'Hospitality 1st',
    'Hospitality 2nd',
    'Hospitality 3rd',
    'Hospitality 4th',
  ];

  // states
  String error = '';
  bool populated = false;
  String email = '';
  String password = '';
  String confirmPassword = '';
  String full_name = '';
  String programLevel = 'Tourism 1st';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // tablet
          if (constraints.minWidth > 600) {
            return Wrap(children: [
              Container(
                color: Colors.grey[350],
                height: 800,
                child: Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 430,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: TextFormField(
                                      validator: (value) => value!.isNotEmpty
                                          ? null
                                          : 'Enter something',
                                      onChanged: (value) {
                                        setState(() {
                                          full_name = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Full Name'),
                                    ),
                                  )),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: false,
                                  hint: Text('Select you program'),
                                  value: programLevel,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  onChanged: (value) {
                                    setState(() {
                                      programLevel = value!;
                                    });
                                  },
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          // -------------------------------------------------------------------
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 130),
                            child: TextFormField(
                              validator: (value) =>
                                  value!.contains('@olopsc.edu.ph')
                                      ? null
                                      : 'OLOPSC email required',
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              decoration: InputDecoration(hintText: 'Email'),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: TextFormField(
                                      validator: (value) => value!.length > 6
                                          ? null
                                          : 'Password must be 6+ chars long',
                                      onChanged: (value) {
                                        setState(() {
                                          password = value;
                                        });
                                      },
                                      decoration:
                                          InputDecoration(hintText: 'Password'),
                                    ),
                                  )),
                              SizedBox(
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: TextFormField(
                                      validator: (value) => value == password
                                          ? null
                                          : "Password didn't match",
                                      onChanged: (value) {
                                        setState(() {
                                          if (confirmPassword.isNotEmpty &&
                                              password.isNotEmpty &&
                                              full_name.isNotEmpty &&
                                              email.isNotEmpty) {
                                            populated = true;
                                          } else {
                                            populated = false;
                                          }
                                          confirmPassword = value;
                                        });
                                      },
                                      decoration:
                                          InputDecoration(hintText: 'Confirm'),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: populated
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      dynamic result = await _auth
                                          .signUpWithEmailAndPassword(
                                              email,
                                              password,
                                              full_name,
                                              programLevel);
                                      if (result == null) {
                                        error = 'Invalid';
                                      }
                                    }
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                  color: populated
                                      ? Color.fromARGB(255, 3, 50, 88)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Swipe down to cancel',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    )),
              ),
            ]);
            // mobile
          } else if (constraints.maxWidth <= 600) {
            return Wrap(children: [
              Container(
                color: Colors.grey[350],
                height: 600,
                child: Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 225,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: TextFormField(
                                      validator: (value) => value!.isNotEmpty
                                          ? null
                                          : 'Enter something',
                                      onChanged: (value) {
                                        setState(() {
                                          full_name = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Full Name'),
                                    ),
                                  )),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: false,
                                  hint: Text('Select you program'),
                                  value: programLevel,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  onChanged: (value) {
                                    setState(() {
                                      programLevel = value!;
                                    });
                                  },
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          // -------------------------------------------------------------------
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 75),
                            child: TextFormField(
                              validator: (value) => value!.contains('@')
                                  ? null
                                  : 'OLOPSC email required',
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              decoration: InputDecoration(hintText: 'Email'),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                              width: 300,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextFormField(
                                  validator: (value) => value!.length > 6
                                      ? null
                                      : 'Password must be 6+ chars long',
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  decoration:
                                      InputDecoration(hintText: 'Password'),
                                ),
                              )),
                          SizedBox(
                              width: 300,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextFormField(
                                  validator: (value) => value == password
                                      ? null
                                      : "Password didn't match",
                                  onChanged: (value) {
                                    setState(() {
                                      if (confirmPassword.isNotEmpty &&
                                          password.isNotEmpty &&
                                          full_name.isNotEmpty &&
                                          email.isNotEmpty) {
                                        populated = true;
                                      } else {
                                        populated = false;
                                      }
                                      confirmPassword = value;
                                    });
                                  },
                                  decoration:
                                      InputDecoration(hintText: 'Confirm'),
                                ),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: populated
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      dynamic result = await _auth
                                          .signUpWithEmailAndPassword(
                                              email,
                                              password,
                                              full_name,
                                              programLevel);
                                      if (result == null) {
                                        error = 'Invalid';
                                      }
                                    }
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              decoration: BoxDecoration(
                                  color: populated
                                      ? Color.fromARGB(255, 3, 50, 88)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Swipe down to cancel',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    )),
              ),
            ]);
          }
          return Loading();
        },
      ),
    );
  }
}
