import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filterProvider);

  return meals.where((meal) {
    if (!meal.isGlutenFree && filters[Filter.glutenFree]!) {
      return false;
    }
    if (!meal.isLactoseFree && filters[Filter.lactoseFree]!) {
      return false;
    }
    if (!meal.isVegetarian && filters[Filter.vegetarian]!) {
      return false;
    }
    if (!meal.isVegan && filters[Filter.vegan]!) {
      return false;
    }
    return true;
  }).toList();
});
