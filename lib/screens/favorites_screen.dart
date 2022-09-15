import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
          child: Text('You have no favorites yet - start adding some'));
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return MealItem(
          title: favoriteMeals[index].title,
          affordability: favoriteMeals[index].affordability,
          complexity: favoriteMeals[index].complexity,
          imageUrl: favoriteMeals[index].imageUrl,
          duration: favoriteMeals[index].duration,
          id: favoriteMeals[index].id,
        );
      },
      itemCount: favoriteMeals.length,
    );
  }
}
