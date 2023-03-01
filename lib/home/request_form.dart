import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/loading.dart';

class RequestForm extends StatefulWidget {
  String id;
  RequestForm({required this.id});

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('items')
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [Text('${snapshot.data!.data()!['item_name']}')],
            ),
          );
        },
      ),
    );
  }
}
