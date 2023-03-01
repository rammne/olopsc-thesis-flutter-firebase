import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/loading.dart';

class ItemList extends StatefulWidget {
  bool checked;
  ItemList({required this.checked});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        child: Icon(Icons.send),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot doc) {
              return SizedBox(
                height: 250,
                child: Card(
                  color: widget.checked ? Colors.white : Colors.grey[400],
                  child: ListTile(
                    onTap: widget.checked
                        ? () {
                            print('${doc.get('item_name')}');
                          }
                        : null,
                    leading: Icon(
                      Icons.image,
                      size: 200,
                    ),
                    title: Container(
                      padding: EdgeInsets.only(
                        top: 100,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${doc.get('item_name')}',
                            style: TextStyle(
                              color: widget.checked
                                  ? Colors.black
                                  : Colors.grey[600],
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            color: widget.checked
                                ? Colors.black
                                : Colors.grey[600],
                            iconSize: 35,
                            onPressed: () async {
                              DocumentSnapshot itemSnapshot =
                                  await FirebaseFirestore.instance
                                      .collection('items')
                                      .doc(doc.id)
                                      .get();
                              int item = itemSnapshot['item_quantity'];
                              await doc.reference
                                  .update({'item_quantity': item - 1});
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text(
                            '${doc.get('item_quantity')}',
                            style: TextStyle(
                                fontSize: 20,
                                color: widget.checked
                                    ? Colors.black
                                    : Colors.grey[600]),
                          ),
                          IconButton(
                            color: widget.checked
                                ? Colors.black
                                : Colors.grey[600],
                            iconSize: 35,
                            onPressed: () async {
                              DocumentSnapshot itemSnapshot =
                                  await FirebaseFirestore.instance
                                      .collection('items')
                                      .doc(doc.id)
                                      .get();
                              int item = itemSnapshot['item_quantity'];
                              await doc.reference
                                  .update({'item_quantity': item + 1});
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
