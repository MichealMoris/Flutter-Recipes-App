import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipes_app/providers/favourites_provider.dart';
import 'package:recipes_app/providers/filter_provider.dart';

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

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _currentIndex = 0;

  void _navigate(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: filteredMeals,
    );
    String title = 'Categories';

    if (_currentIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(meals: favouriteMeals);
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
