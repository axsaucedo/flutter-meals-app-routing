import 'package:flutter/material.dart';

import "./dummy_data.dart";
// import "./screens/tabs_screen.dart";
// import "./screens/meal_detail_screen.dart";
// import "./screens/category_meals_screen.dart";
// import "./screens/filters_screen.dart";
import "./models/meal.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if ((_filters["gluten"] ?? true) && !meal.isGlutenFree ||
            (_filters["lactose"] ?? true) && !meal.isLactoseFree ||
            (_filters["vegan"] ?? true) && !meal.isVegan ||
            (_filters["vegetarian"] ?? true) && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavourite(String mealId) {
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "DeliMeals",
      // theme: ThemeData(
      //   primarySwatch: Colors.pink,
      //   accentColor: Colors.amber,
      //   //fontFamily: "Raleway",
      //   textTheme: ThemeData.light().textTheme.copyWith(
      //     bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
      //     bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
      //     headline1: TextStyle(
      //       fontSize: 20,
      //       //fontFamily: "RobotoCondensed",
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //),
      home: Text("Hello"),
    );
  }

}
