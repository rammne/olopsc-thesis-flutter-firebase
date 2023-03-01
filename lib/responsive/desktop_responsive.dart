import 'package:flutter/material.dart';

class DesktopResponsive extends StatefulWidget {
  const DesktopResponsive({super.key});

  @override
  State<DesktopResponsive> createState() => _DesktopResponsiveState();
}

class _DesktopResponsiveState extends State<DesktopResponsive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('DESKTOP'),
      ),
    );
  }
}
