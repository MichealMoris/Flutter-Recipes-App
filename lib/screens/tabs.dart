import 'package:flutter/material.dart';
import 'package:recipes_app/models/meal.dart';
import 'package:recipes_app/screens/categories.dart';
import 'package:recipes_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  final List<Meal> _favMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(message),
      ),
    );
  }

  void _toggleMeal(Meal meal) {
    setState(() {
      if (_favMeals.contains(meal)) {
        _favMeals.remove(meal);
        _showInfoMessage('Meal is no longer favourite!');
      } else {
        _favMeals.add(meal);
        _showInfoMessage('Meal marked as favourite!');
      }
    });
  }

  void _navigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(onToggleFavourite: _toggleMeal);
    String title = 'Pick up a category';

    if (_currentIndex == 1) {
      activePage =
          MealsScreen(meals: _favMeals, onToggleFavourite: _toggleMeal);
      title = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourite',
          ),
        ],
        onTap: _navigate,
      ),
    );
  }
}
