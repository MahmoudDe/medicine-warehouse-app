import 'package:medicine_warehouse/models/category.dart';
import 'package:medicine_warehouse/models/medicine.dart';
import 'package:medicine_warehouse/screens/medicines.dart';
import 'package:flutter/material.dart';
import 'package:medicine_warehouse/data/dummy_data.dart';
import 'package:medicine_warehouse/widgets/category_grid_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_warehouse/screens/home_page.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({required this.foundCategories, super.key});
  final List<Category> foundCategories;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;

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
    return GridView.builder(
      padding: EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: foundCategories.length,
      itemBuilder: (context, index) {
        return CategoryGridItem(
          category: foundCategories[index],
          onSelectedCategory: () {
            _selectedCategory(foundCategories[index], context);
          },
        );
      },
    );
  }
}
