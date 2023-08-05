import 'package:flutter/material.dart';

class MealItemData extends StatelessWidget {
  final IconData icon;
  final String label;
  const MealItemData({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        icon,
        size: 17,
        color: Colors.white,
      ),
      const SizedBox(
        width: 6,
      ),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      )
    ]);
  }
}
