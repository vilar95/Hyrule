import 'package:flutter/material.dart';
import 'package:hyrule/screens/components/category.dart';
import 'package:hyrule/utils/consts/categories.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Escolha uma Categoria"),
          centerTitle: true,
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
              children: 
                categories.keys.map((e) => Category(category: e)).toList(),
        ),
      ),
    );
  }
}
