import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/accepted_requests.dart';
import 'package:flutter_application_1/home/rejected_requests.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Accepted',
                  ),
                  Tab(
                    text: 'Rejected',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  AcceptedRequests(),
                  RejectedRequests(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
