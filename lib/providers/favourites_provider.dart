import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);
  bool toggleMealFavouriteStatus(Meal mMeal) {
    final isExist = state.contains(mMeal);
    if (isExist) {
      state = state.where((meal) => meal.id != mMeal.id).toList();
      return false;
    } else {
      state = [...state, mMeal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
        (ref) => FavouriteMealsNotifier());
