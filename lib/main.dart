import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/wrapper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.grey[350],
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        navigationRailTheme:
            NavigationRailThemeData(backgroundColor: Colors.grey[350]),
        iconTheme: IconThemeData(color: Colors.black),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.all(Colors.black),
          ),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[350]),
        scaffoldBackgroundColor: Colors.grey[350],
      ),
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}
