import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/screens/detailed_meal_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        '/': (ctx) => const CategoriesScreen(),
        CategoryMealsScreen.routeName: (ctx) => const CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => const MealDetailScreen(),
      },
      onGenerateRoute: (settings){
        if (kDebugMode) {
          print(settings.arguments);
        }
      //   // used during dynamically generated routes on highly dynamic apps
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
