import 'package:flutter/material.dart';

import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArMeal'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 240,
            childAspectRatio: 4 / 3,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24),
        children: [
          ...dummyCategories
              .map((e) => CategoryItem(title: e.title, color: e.color, id: e.id,))
              .toList()
        ],
      ),
    );
  }
}
