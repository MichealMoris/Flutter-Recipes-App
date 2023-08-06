import 'package:flutter/material.dart';
import 'package:recipes_app/widgets/filter_switch_tile.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  final Map<Filter, bool> appliedFilters;
  const FiltersScreen({super.key, required this.appliedFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetrianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    _glutenFreeFilterSet = widget.appliedFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.appliedFilters[Filter.lactoseFree]!;
    _vegetrianFilterSet = widget.appliedFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.appliedFilters[Filter.vegan]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetrianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
          return false;
        },
        child: Column(
          children: [
            FilterSwitchTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              title: 'Gluten-free',
              subtitle: 'only include gluten-free meals.',
            ),
            FilterSwitchTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: 'Lactose-free',
              subtitle: 'only include lactose-free meals.',
            ),
            FilterSwitchTile(
              value: _vegetrianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetrianFilterSet = isChecked;
                });
              },
              title: 'Vegetrian',
              subtitle: 'only include vegetrian meals.',
            ),
            FilterSwitchTile(
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: 'Vegan',
              subtitle: 'only include v egan meals.',
            ),
          ],
        ),
      ),
    );
  }
}
