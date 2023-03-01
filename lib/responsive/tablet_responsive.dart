import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';

import '../home/bag.dart';
import '../home/item_list.dart';
import 'package:flutter_application_1/home/history.dart';

import '../home/request_page.dart';

class TabletResponsive extends StatefulWidget {
  const TabletResponsive({super.key});

  @override
  State<TabletResponsive> createState() => _TabletResponsiveState();
}

class _TabletResponsiveState extends State<TabletResponsive> {
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
        page = Bag();
        break;
      case 2:
        page = History();
        break;
      case 3:
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
                      icon: Icon(Icons.shopping_bag),
                      label: Text('Bag'),
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
