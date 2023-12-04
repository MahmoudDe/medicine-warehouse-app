import 'package:flutter/material.dart';
import 'package:medicine_warehouse/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem(
      {required this.category, required this.onSelectedCategory, super.key});
  final Category category;
  final void Function() onSelectedCategory;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Column(
      children: [
        InkWell(
          onTap: onSelectedCategory,
          splashColor: Colors.grey.shade200,
          //borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
            child: Image.asset(
              category.imageUrl,
              fit: BoxFit.contain,
              height: mediaQuery.height / 16,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          category.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ],
    );
  }
}
