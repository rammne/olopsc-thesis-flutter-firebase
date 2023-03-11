import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/loading.dart';

class AcceptedRequests extends StatefulWidget {
  const AcceptedRequests({super.key});

  @override
  State<AcceptedRequests> createState() => _AcceptedRequestsState();
}

class _AcceptedRequestsState extends State<AcceptedRequests> {
  @override
  Widget build(BuildContext context) {
    void _showSettings(remarks) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.grey[350],
              child: Center(
                  child: Text(
                '${remarks}',
                style: TextStyle(fontSize: 20),
              )),
            );
          });
    }

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
              return Container(
                child: doc.get('status') == 'ACCEPTED'
                    ? Card(
                        color: Colors.grey[350],
                        child: ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              try {
                                _showSettings(doc.get('remarks'));
                              } catch (e) {
                                _showSettings('No remarks');
                              }
                            },
                            icon: Icon(Icons.mail),
                          ),
                          title: doc.get('status') == 'ACCEPTED'
                              ? Text('${doc.get('item_name_requested')}')
                              : null,
                          subtitle: doc.get('status') == 'ACCEPTED'
                              ? Text('${doc.get('item_quantity_requested')}')
                              : null,
                        ),
                      )
                    : null,
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
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    child: doc.get('status') == 'ACCEPTED'
                        ? ListTile(
                            trailing: IconButton(
                                onPressed: () {
                                  try {
                                    _showSettings(doc.get('remarks'));
                                  } catch (e) {
                                    _showSettings('No remarks');
                                  }
                                },
                                icon: Icon(Icons.mail)),
                            title: doc.get('status') == 'ACCEPTED'
                                ? Text(
                                    '${doc.get('item_name_requested')}',
                                    style: constraints.maxWidth >= 600
                                        ? TextStyle(fontSize: 25)
                                        : TextStyle(fontSize: 20),
                                  )
                                : null,
                            subtitle: doc.get('status') == 'ACCEPTED'
                                ? Text(
                                    '${doc.get('item_quantity_requested')}',
                                    style: constraints.maxWidth >= 600
                                        ? TextStyle(fontSize: 20)
                                        : TextStyle(fontSize: 16),
                                  )
                                : null,
                          )
                        : null,
                  );
                },
              );
            }).toList());
          },
        );
        ;
      }
    });
  }
}
