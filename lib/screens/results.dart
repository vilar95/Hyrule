import 'package:flutter/material.dart';
import 'package:hyrule/utils/consts/categories.dart';

class Results extends StatelessWidget {
  const Results({super.key,  required this.category});
  final String category;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(categories[category]!),
        ),
      ),
    );
  }
}
