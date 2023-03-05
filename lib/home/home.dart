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
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    Widget page = ItemList(checked: checked);
    switch (selectedIndex) {
      case 0:
        page = ItemList(
          checked: checked,
        );
        break;
      case 1:
        page = History();
        break;
      case 2:
        page = RequestPage();
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
                  trailing: selectedIndex == 0
                      ? Row(
                          children: [
                            Text('Activate'),
                            Checkbox(
                              value: checked,
                              onChanged: (value) {
                                setState(() {
                                  checked = value!;
                                });
                              },
                            ),
                          ],
                        )
                      : null,
                  minExtendedWidth: 150,
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.inventory),
                      label: Text('Lists'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.work_history),
                      label: Text('History'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.pending),
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
