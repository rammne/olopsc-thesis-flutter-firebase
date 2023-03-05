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
        AuthService().signOut();
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
                  trailing: IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      AuthService().signOut();
                    },
                  ),
                  minExtendedWidth: 150,
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.inventory,
                        size: constraints.maxWidth >= 600 ? 45 : null,
                      ),
                      label: Text('Lists'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.work_history,
                        size: constraints.maxWidth >= 600 ? 45 : null,
                      ),
                      label: Text('History'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.pending,
                        size: constraints.maxWidth >= 600 ? 45 : null,
                      ),
                      label: Text('Requests'),
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
