import 'package:flutter/material.dart';
import 'package:recipes_app/models/meal.dart';
import 'package:recipes_app/widgets/meals_list/meal_list_item.dart';

class MealsList extends StatelessWidget {
  final List<Meal> meals;
  const MealsList({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealListItem(meal: meals[index]));
  }
}
