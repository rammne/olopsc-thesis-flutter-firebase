import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/request_form.dart';
import 'package:flutter_application_1/shared/loading.dart';

class ItemList extends StatefulWidget {
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  TextEditingController _controller = TextEditingController();
  late List<Map<String, dynamic>> selectedItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    void _showSettings(String id, String itemName) {
      showModalBottomSheet(
        backgroundColor: Colors.grey[350],
        context: context,
        builder: (context) {
          return Container(
            height: 700,
            child: RequestForm(
              id: id,
              itemName: itemName,
            ),
          );
        },
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      // mobile view
      if (constraints.maxWidth < 400) {
        return Scaffold(
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('items').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else {
                return ListView(
                  children: snapshot.hasData
                      ? snapshot.data!.docs.map((DocumentSnapshot doc) {
                          return SizedBox(
                            height: 150,
                            child: Card(
                              color: Colors.grey[350],
                              child: ListTile(
                                subtitle: Container(
                                  child: Text('${doc.get('item_quantity')}'),
                                ),
                                onTap: () {
                                  _showSettings(doc.id, doc.get('item_name'));
                                },
                                leading: Icon(
                                  Icons.image,
                                  size: 100,
                                ),
                                title: Container(
                                  padding: EdgeInsets.only(
                                    top: 50,
                                  ),
                                  child: Text(
                                    '${doc.get('item_name')}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList()
                      : [],
                );
              }
            },
          ),
        );
        // tablet view
      } else if (constraints.maxWidth <= 800) {
        return Scaffold(
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('items').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else {
                return ListView(
                  children: snapshot.hasData
                      ? snapshot.data!.docs.map((DocumentSnapshot doc) {
                          return SizedBox(
                            height: 150,
                            child: Card(
                              color: Colors.grey[350],
                              child: ListTile(
                                subtitle: Container(
                                  child: Text('${doc.get('item_quantity')}'),
                                ),
                                onTap: () {
                                  _showSettings(doc.id, doc.get('item_name'));
                                },
                                leading: Icon(
                                  Icons.image,
                                  size: 125,
                                ),
                                title: Container(
                                  padding: EdgeInsets.only(
                                    top: 50,
                                  ),
                                  child: Text(
                                    '${doc.get('item_name')}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList()
                      : [],
                );
              }
            },
          ),
        );
      } else {
        return Scaffold(
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('items').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else {
                return ListView(
                  children: snapshot.hasData
                      ? snapshot.data!.docs.map((DocumentSnapshot doc) {
                          return SizedBox(
                            height: 150,
                            child: Card(
                              color: Colors.grey[350],
                              child: ListTile(
                                subtitle: Container(
                                  child: Text('${doc.get('item_quantity')}'),
                                ),
                                onTap: () {
                                  _showSettings(doc.id, doc.get('item_name'));
                                },
                                leading: Icon(
                                  Icons.image,
                                  size: 125,
                                ),
                                title: Container(
                                  padding: EdgeInsets.only(
                                    top: 50,
                                  ),
                                  child: Text(
                                    '${doc.get('item_name')}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList()
                      : [],
                );
              }
            },
          ),
        );
      }
    });
  }
}
