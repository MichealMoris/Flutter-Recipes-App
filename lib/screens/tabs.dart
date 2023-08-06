import 'package:flutter/material.dart';
import 'package:recipes_app/data/dummy_data.dart';
import 'package:recipes_app/models/meal.dart';
import 'package:recipes_app/screens/categories.dart';
import 'package:recipes_app/screens/filters.dart';
import 'package:recipes_app/screens/meals.dart';
import 'package:recipes_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  final List<Meal> _favMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            appliedFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = dummyMeals.where((meal) {
      if (!meal.isGlutenFree && _selectedFilters[Filter.glutenFree]!) {
        return false;
      }
      if (!meal.isLactoseFree && _selectedFilters[Filter.lactoseFree]!) {
        return false;
      }
      if (!meal.isVegetarian && _selectedFilters[Filter.vegetarian]!) {
        return false;
      }
      if (!meal.isVegan && _selectedFilters[Filter.vegan]!) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFavourite: _toggleMeal,
      availableMeals: filteredMeals,
    );
    String title = 'Categories';

    if (_currentIndex == 1) {
      activePage =
          MealsScreen(meals: _favMeals, onToggleFavourite: _toggleMeal);
      title = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
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
