import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter_crud/bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App with Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey[850],
        colorScheme: ColorScheme.dark(
          primary: Colors.grey[700]!,
          secondary: Colors.grey[600]!,
        ),
      ),
      home: const BottomBar(),
    );
  }
}
