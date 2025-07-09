import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(ChromaApp());
}

class ChromaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHROMA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // You can customize this
      home: SplashScreen(),
    );
  }
}
