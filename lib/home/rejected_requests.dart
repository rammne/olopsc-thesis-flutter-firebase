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
              .collection('rejected_requests')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            }
            return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              return Card(
                elevation: 3,
                color: Colors.blue[100],
                child: ListTile(
                  title: Text('${doc.get('item_name_rejected')}'),
                  subtitle: Text('${doc.get('item_quantity_rejected')}'),
                ),
              );
            }).toList());
          },
        );
      } else {
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
              return Card(
                elevation: 3,
                color: Colors.blue[100],
                child: ListTile(
                  title: Text(
                    '${doc.get('item_name_rejected')}',
                    style: constraints.maxWidth >= 600
                        ? TextStyle(fontSize: 25)
                        : TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    '${doc.get('item_quantity_rejected')}',
                    style: constraints.maxWidth >= 600
                        ? TextStyle(fontSize: 20)
                        : TextStyle(fontSize: 16),
                  ),
                ),
              );
            }).toList());
          },
        );
        ;
      }
    });
  }
}
