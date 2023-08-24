import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app/providers/filter_provider.dart';
import 'package:recipes_app/widgets/filter_switch_tile.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filterProvider);
    return Scaffold(
      // drawer: MainDrawer(onSelectScreen: ((identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // })),
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          FilterSwitchTile(
            value: filters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.glutenFree, isChecked);
            },
            title: 'Gluten-free',
            subtitle: 'only include gluten-free meals.',
          ),
          FilterSwitchTile(
            value: filters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.lactoseFree, isChecked);
            },
            title: 'Lactose-free',
            subtitle: 'only include lactose-free meals.',
          ),
          FilterSwitchTile(
            value: filters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.vegetarian, isChecked);
            },
            title: 'Vegetrian',
            subtitle: 'only include vegetrian meals.',
          ),
          FilterSwitchTile(
            value: filters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.vegan, isChecked);
            },
            title: 'Vegan',
            subtitle: 'only include v egan meals.',
          ),
        ],
      ),
    );
  }
}
