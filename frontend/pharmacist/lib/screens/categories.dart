import 'package:medicine_warehouse/models/category.dart';
import 'package:medicine_warehouse/screens/medicines.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/data/dummy_data.dart';
import 'package:medicine_warehouse/widgets/category_grid_item.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectedCategory(Category category, BuildContext context) {
    final filterMedicines = availableMedicines
        .where((medicine) => medicine.classification.contains(category.title))
        .toList();
    //medicine that have the same id of that category => put them as list in filteredMedicines, so that we will have => List<Medicine>filteredMedicines

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MedicinesScreen(
          medicines: filterMedicines,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectedCategory: () {
              _selectedCategory(category, context);
            },
          )
      ],
    );
  }
}
