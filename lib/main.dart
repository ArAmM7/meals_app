import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/screens/detailed_meal_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'package:meals_app/models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favoriteMeals = [];

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals app',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                  fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold),
              bodyLarge: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(20, 51, 51, 1)),
              bodyMedium: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(20, 51, 51, 1)),
              bodySmall: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(20, 51, 51, 1)),
            ),
        colorScheme: const ColorScheme(
            primary: Colors.pink,
            onPrimary: Colors.white,
            secondary: Colors.amber,
            onSecondary: Colors.black87,
            brightness: Brightness.light,
            background: Colors.white70,
            error: Colors.red,
            onBackground: Colors.black87,
            onError: Colors.black87,
            surface: Colors.white70,
            onSurface: Colors.black87),
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        if (kDebugMode) {
          print('onGenerateRoute');
          print(settings.arguments);
        }
        return null;
        //   // used during dynamically generated routes on highly dynamic apps
        //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        if (kDebugMode) {
          print('onUnknownRoute');
          print(settings.arguments);
        }
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }

  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;

      _availableMeals = dummyMeals.where((element) {
        if (_filters['gluten']! && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian']! && !element.isVegetarian) {
          return false;
        }
        if (_filters['vegan']! && !element.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(
        () {
          _favoriteMeals.removeAt(existingIndex);
        },
      );
    } else {
      setState(
        () {
          _favoriteMeals
              .add(dummyMeals.firstWhere((element) => mealId == element.id));
        },
      );
    }
  }
}
