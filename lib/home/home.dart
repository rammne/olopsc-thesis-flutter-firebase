import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'item_list.dart';
import 'package:flutter_application_1/home/history.dart';

import 'request_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();

  // states
  int selectedIndex = 0;
  bool checked = true;
  bool navigationExtend = true;
  @override
  Widget build(BuildContext context) {
    Widget page = ItemList();
    switch (selectedIndex) {
      case 0:
        page = ItemList();
        break;
      case 1:
        page = History();
        break;
      case 2:
        page = RequestPage();
        break;
      case 3:
        _auth.signOut();
        break;
      case 4:
        navigationExtend = !navigationExtend;
        break;
      default:
        throw UnimplementedError('no widget found for ${selectedIndex}');
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  // trailing: IconButton(
                  //   icon: Icon(Icons.logout),
                  //   onPressed: () {
                  //     AuthService().signOut();
                  //   },
                  // ),
                  minExtendedWidth: 150,
                  extended: navigationExtend,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.list_rounded,
                        size: constraints.maxWidth >= 600 ? 45 : null,
                      ),
                      label: Text('Lists'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.history,
                        size: constraints.maxWidth >= 600 ? 45 : null,
                      ),
                      label: Text('History'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.pending_outlined,
                        size: constraints.maxWidth >= 600 ? 45 : null,
                      ),
                      label: Text('Requests'),
                    ),
                    NavigationRailDestination(
                      padding: EdgeInsets.only(top: constraints.maxHeight / 2),
                      icon: Icon(Icons.logout_rounded),
                      label: Text('Logout'),
                    ),
                    NavigationRailDestination(
                      icon: navigationExtend
                          ? Icon(Icons.arrow_back_ios_new_rounded)
                          : Icon(Icons.arrow_forward_ios_rounded),
                      label: Text(''),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
