import 'package:flutter/material.dart';
import 'package:recipes_app/models/meal.dart';
import 'package:recipes_app/screens/meal_details.dart';
import 'package:recipes_app/widgets/meals_list/meals_list.dart';
import 'package:recipes_app/widgets/nothing_found.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;
  const MealsScreen({super.key, this.title, required this.meals});

  void _mealClick(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = meals.isNotEmpty
        ? MealsList(
            meals: meals,
            onMealSelected: (meal) {
              _mealClick(context, meal);
            },
          )
        : const NothingFound();

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
