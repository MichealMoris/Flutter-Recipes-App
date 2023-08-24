import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app/models/meal.dart';
import 'package:recipes_app/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  final Meal meal;
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouriteMealsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              final isAdded = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleMealFavouriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isAdded
                      ? 'Marked as Favourite.'
                      : 'This meal is not favourite anymore.'),
                ),
              );
            },
            icon: Icon(favourites.contains(meal) ? Icons.star : Icons.star_border_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              ...meal.ingredients
                  .map((ingredient) => Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          ingredient,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ))
                  .toList(),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              ...meal.steps
                  .map((step) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          step,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
