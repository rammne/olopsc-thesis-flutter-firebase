import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/loading.dart';

class RequestForm extends StatefulWidget {
  String id;
  String itemName;
  RequestForm({required this.id, required this.itemName});

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final _formKey = GlobalKey<FormState>();
  int? val;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Text(
                  '${widget.itemName}',
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        val = int.parse(value);
                      });
                    },
                    validator: (value) => value!.isNotEmpty ? null : '',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('requests')
                          .doc(widget.id)
                          .set({
                        'item_name_requested': widget.itemName,
                        'item_quantity_requested': val,
                        'status': 'PENDING'
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          )),
    );
  }
}
