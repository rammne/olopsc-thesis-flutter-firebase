// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  Widget mobileDevice;
  Widget tabletDevice;
  Widget desktopDevice;
  ResponsiveLayout({
    Key? key,
    required this.mobileDevice,
    required this.tabletDevice,
    required this.desktopDevice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 400) {
          return mobileDevice;
        } else if (constraints.maxWidth <= 800) {
          return tabletDevice;
        } else {
          return desktopDevice;
        }
      },
    );
  }
}
