import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/loading.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('requests')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }
        return LayoutBuilder(builder: (context, constraints) {
          // mobile
          if (constraints.maxWidth < 400) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                return Container(
                  height: 80,
                  child: doc.get('status') == 'PENDING'
                      ? Card(
                          child: ListTile(
                            trailing: IconButton(
                              color: Colors.red,
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('requests')
                                    .doc(doc.id)
                                    .delete();
                              },
                              icon: Icon(Icons.cancel),
                            ),
                            leading: Icon(
                              Icons.image,
                              size: 50,
                            ),
                            title: Text('${doc.get('item_name_requested')}'),
                            subtitle: Text(
                                '${doc.get('item_quantity_requested')} --- ${doc.get('status')}'),
                          ),
                        )
                      : null,
                );
              }).toList(),
            );
          } else if (constraints.maxWidth <= 800) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                return Container(
                  height: 100,
                  child: doc.get('status') == 'PENDING'
                      ? Card(
                          child: ListTile(
                            trailing: IconButton(
                              color: Colors.red,
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('requests')
                                    .doc(doc.id)
                                    .delete();
                              },
                              icon: Icon(Icons.cancel),
                            ),
                            leading: Icon(
                              Icons.image,
                              size: 50,
                            ),
                            title: Text('${doc.get('item_name_requested')}'),
                            subtitle: Text(
                                '${doc.get('item_quantity_requested')} --- ${doc.get('status')}'),
                          ),
                        )
                      : null,
                );
              }).toList(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                return Container(
                  height: 100,
                  child: doc.get('status') == 'PENDING'
                      ? Card(
                          child: ListTile(
                            trailing: IconButton(
                              color: Colors.red,
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('requests')
                                    .doc(doc.id)
                                    .delete();
                              },
                              icon: Icon(Icons.cancel),
                            ),
                            leading: Icon(
                              Icons.image,
                              size: 50,
                            ),
                            title: Text('${doc.get('item_name_requested')}'),
                            subtitle: Text(
                                '${doc.get('item_quantity_requested')} --- ${doc.get('status')}'),
                          ),
                        )
                      : null,
                );
              }).toList(),
            );
          }
        });
      },
    );
  }
}
