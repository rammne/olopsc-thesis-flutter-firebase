import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/loading.dart';

class RejectedRequests extends StatefulWidget {
  const RejectedRequests({super.key});

  @override
  State<RejectedRequests> createState() => _RejectedRequestsState();
}

class _RejectedRequestsState extends State<RejectedRequests> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 400) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('requests')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              return ListTile(
                title: doc.get('status') == 'REJECTED'
                    ? Text('${doc.get('item_name_requested')}')
                    : Text(''),
                subtitle: doc.get('status') == 'REJECTED'
                    ? Text('${doc.get('item_quantity_requested')}')
                    : Text(''),
              );
            }).toList());
          },
        );
      } else {
        return Text('...');
      }
    });
  }
}
