import 'package:flutter/material.dart';
import 'package:lesson61/views/screens/home_page.dart';
import 'package:lesson61/views/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
