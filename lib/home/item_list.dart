import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/request_form.dart';
import 'package:flutter_application_1/home/show_settings.dart';

class ItemList extends StatefulWidget {
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late List<Map<String, dynamic>> selectedItems = [];
  double screenHeight = 0;
  double screenWidth = 0;
  bool startAnimation = false;
  String itemNameQuery = '';
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<Widget> _itemList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _addItem();
  //   });
  // }

  // final Stream<QuerySnapshot> _itemStream =
  //     FirebaseFirestore.instance.collection('items').snapshots();

  // Future<void> _addItem() async {
  //   Future ft = Future(() {});
  //   _itemStream.listen((QuerySnapshot data) {
  //     // ignore: avoid_function_literals_in_foreach_calls
  //     data.docChanges.forEach((change) {
  //       if (change.type == DocumentChangeType.added ||
  //           change.type == DocumentChangeType.modified) {
  //         ft = ft.then((_) {
  //           return Future.delayed(const Duration(milliseconds: 250), () {
  //             _itemList.add(_itemListBuilder(change.doc));
  //             _listKey.currentState?.insertItem(_itemList.length - 1);
  //           });
  //         });
  //       }
  //       // else if (change.type == DocumentChangeType.removed) {
  //       //   ft = ft.then((_) {
  //       //     return Future.delayed(const Duration(milliseconds: 250), () {
  //       //       int index = _itemList
  //       //           .indexWhere((item) => item.key == Key(change.doc.id));
  //       //       if (index != -1) {
  //       //         _itemList.removeAt(index);
  //       //         _listKey.currentState
  //       //             ?.removeItem(index, (context, animation) => Container());
  //       //       }
  //       //     });
  //       //   });
  //       // }
  //     });
  //   });
  // }

  // Widget _itemListBuilder(DocumentSnapshot itemData) {
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection('status').snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('Something went wrong');
  //       }
  //       return Column(
  //         children: snapshot.data?.docs.map((DocumentSnapshot doc) {
  //               return Card(
  //                 color:
  //                     doc.get('status') ? Colors.blue[100] : Colors.grey[200],
  //                 elevation: 3,
  //                 child: ListTile(
  //                   onTap: doc.get('status')
  //                       ? () {
  //                           Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                               builder: (context) => ShowSettings(
  //                                   itemId: itemData.id,
  //                                   itemName: itemData['item_name'],
  //                                   availableItems:
  //                                       itemData['available_items'] ?? 0),
  //                             ),
  //                           );
  //                         }
  //                       : null,
  //                   leading: Hero(
  //                     tag: itemData['item_name'],
  //                     child: const Icon(
  //                       Icons.image,
  //                       size: 45,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   title: Text(
  //                     '${itemData['item_name']} (${itemData['available_items'] ?? '0'})',
  //                     style: const TextStyle(
  //                         fontWeight: FontWeight.w600, fontSize: 16),
  //                   ),
  //                 ),
  //               );
  //             }).toList() ??
  //             [],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    // void _showSettings(String id, String itemName) {
    //   showModalBottomSheet(
    //     backgroundColor: Colors.blue[100],
    //     context: context,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(30),
    //         topRight: Radius.circular(30),
    //       ),
    //     ),
    //     builder: (context) {
    //       return SizedBox(
    //         height: 700,
    //         child: RequestForm(
    //           id: id,
    //           itemName: itemName,
    //         ),
    //       );
    //     },
    //   );
    // }

    // Tween<Offset> _offset =
    //     Tween(begin: const Offset(1, 0), end: const Offset(0, 0));

    return Column(
      children: [
        SafeArea(
          child: SizedBox(
            width: screenWidth / 1.5,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Item Name...',
                icon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  itemNameQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
        Expanded(
            child: Scaffold(
          body: StreamBuilder(
            stream: itemNameQuery != '' && itemNameQuery != null
                ? FirebaseFirestore.instance
                    .collection('items')
                    .where('searchable_item_name', arrayContains: itemNameQuery)
                    .snapshots()
                : FirebaseFirestore.instance.collection('items').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else {
                return ListView(
                  children: snapshot.hasData
                      ? snapshot.data!.docs.map((DocumentSnapshot doc) {
                          return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('status')
                                .snapshots(),
                            builder: (context, snapshotStatus) {
                              if (snapshotStatus.hasError) {
                                return Text('Error');
                              }
                              return Column(
                                children: (snapshotStatus.data?.docs ?? [])
                                    .map((docStatus) {
                                  return SizedBox(
                                    child: Card(
                                      elevation: 3,
                                      color: docStatus.get('status')
                                          ? Colors.blue[100]
                                          : Colors.grey[200],
                                      child: ListTile(
                                        subtitle: Container(
                                          child: Text(
                                              '${doc.get('available_items')}'),
                                        ),
                                        onTap: docStatus.get('status')
                                            ? () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowSettings(
                                                      itemId: doc.id,
                                                      itemName:
                                                          doc.get('item_name'),
                                                      availableItems: doc.get(
                                                              'available_items') ??
                                                          0,
                                                    ),
                                                  ),
                                                );
                                              }
                                            : null,
                                        leading: Hero(
                                          tag: doc.get('item_name'),
                                          child: const Icon(
                                            Icons.image,
                                            size: 45,
                                            color: Colors.black,
                                          ),
                                        ),
                                        title: Text(
                                          '${doc.get('item_name')} (${doc.get('available_items') ?? '0'})',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          );
                        }).toList()
                      : [],
                );
              }
            },
          ),
        )),
      ],
    );
  }
}

// else if (constraints.maxWidth <= 800) {
//   return Scaffold(
//     body: StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('items').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         } else {
//           return ListView(
//             children: snapshot.hasData
//                 ? snapshot.data!.docs.map((DocumentSnapshot doc) {
//                     return SizedBox(
//                       height: 150,
//                       child: Card(
//                         elevation: 6,
//                         color: Colors.blue[100],
//                         child: ListTile(
//                           subtitle: Container(
//                             child: Text('${doc.get('item_quantity')}'),
//                           ),
//                           onTap: () {
//                             _showSettings(doc.id, doc.get('item_name'));
//                           },
//                           leading: Icon(
//                             Icons.image,
//                             size: 100,
//                           ),
//                           title: Container(
//                             padding: EdgeInsets.only(
//                               top: 50,
//                             ),
//                             child: Text(
//                               '${doc.get('item_name')}',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList()
//                 : [],
//           );
//         }
//       },
//     ),
//   );

// else if (constraints.maxWidth <= 800) {
//   return Scaffold(
//     body: StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('items').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         } else {
//           return ListView(
//             children: snapshot.hasData
//                 ? snapshot.data!.docs.map((DocumentSnapshot doc) {
//                     return SizedBox(
//                       height: 150,
//                       child: Card(
//                         elevation: 6,
//                         color: Colors.blue[100],
//                         child: ListTile(
//                           subtitle: Container(
//                             child: Text('${doc.get('item_quantity')}'),
//                           ),
//                           onTap: () {
//                             _showSettings(doc.id, doc.get('item_name'));
//                           },
//                           leading: Icon(
//                             Icons.image,
//                             size: 100,
//                           ),
//                           title: Container(
//                             padding: EdgeInsets.only(
//                               top: 50,
//                             ),
//                             child: Text(
//                               '${doc.get('item_name')}',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList()
//                 : [],
//           );
//         }
//       },
//     ),
//   );
// } else {
//   return Scaffold(
//     body: StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('items').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         } else {
//           return ListView(
//             children: snapshot.hasData
//                 ? snapshot.data!.docs.map((DocumentSnapshot doc) {
//                     return SizedBox(
//                       height: 150,
//                       child: Card(
//                         color: Color(0xFFBBDEFB),
//                         child: ListTile(
//                           subtitle: Container(
//                             child: Text('${doc.get('item_quantity')}'),
//                           ),
//                           onTap: () {
//                             _showSettings(doc.id, doc.get('item_name'));
//                           },
//                           leading: Icon(
//                             Icons.image,
//                             size: 125,
//                           ),
//                           title: Container(
//                             padding: EdgeInsets.only(
//                               top: 50,
//                             ),
//                             child: Text(
//                               '${doc.get('item_name')}',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList()
//                 : [],
//           );
//         }
//       },
//     ),
//   );
// }
