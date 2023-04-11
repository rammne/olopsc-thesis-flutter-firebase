// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/request_form.dart';

class ShowSettings extends StatefulWidget {
  String itemId;
  String itemName;
  int availableItems;
  ShowSettings(
      {required this.itemId,
      required this.itemName,
      required this.availableItems});

  @override
  State<ShowSettings> createState() => _ShowSettingsState();
}

class _ShowSettingsState extends State<ShowSettings> {
  var faker = Faker();
  @override
  Widget build(BuildContext context) {
    void _onSettingsTap() {
      showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (context) {
          return SizedBox(
              height: 700,
              child: RequestForm(
                id: widget.itemId,
                itemName: widget.itemName,
                availableItems: widget.availableItems,
              ));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          ClipRRect(
            child: Hero(
              tag: widget.itemName,
              child: const Icon(
                Icons.image,
                size: 400,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: Text(
              '${widget.itemName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            subtitle: Text('${widget.availableItems}'),
            trailing: IconButton(
              onPressed: () {
                _onSettingsTap();
              },
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                faker.lorem.sentences(10).toString(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
