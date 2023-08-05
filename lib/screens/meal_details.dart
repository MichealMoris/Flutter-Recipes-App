import 'package:flutter/material.dart';
import 'package:recipes_app/models/meal.dart';

class MealDetailsScreen extends StatefulgitWidget {
  final Meal meal;
  const MealDetailsScreen({super.key, required this.meal});

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meal.title,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network(widget.meal.imageUrl),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              ...widget.meal.ingredients
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
                height: 20,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              ...widget.meal.steps
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