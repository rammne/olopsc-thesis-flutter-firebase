import 'package:flutter/material.dart';

class MobileResponsive extends StatefulWidget {
  const MobileResponsive({super.key});

  @override
  State<MobileResponsive> createState() => _MobileResponsiveState();
}

class _MobileResponsiveState extends State<MobileResponsive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('MOBILE'),
      ),
    );
  }
}
