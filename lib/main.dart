import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hyrule/screens/categories.dart';

void main() {
  runApp(const Hyrule());
}

class Hyrule extends StatelessWidget {
  const Hyrule({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hyrule',
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.horizontal,
          ),
          TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.horizontal,
          ),
        }),
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const Categories(),
    );
  }
}
