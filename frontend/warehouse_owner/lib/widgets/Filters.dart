// filters.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_owner_app/widgets/TextField.dart';
import '../Provider/Medicine_Provider.dart';
import 'Button.dart';


class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  final TextEditingController _controller = TextEditingController();
  String selectedCategory = '';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final medicineProvider = Provider.of<MedicineProvider>(context);
    final categories = medicineProvider.categories.where((category) => category.contains(searchQuery)).toList(); // Filter the categories based on the search query

    return Container(
      color: Colors.grey.shade200, // Change this color to your preference
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Categories:',
              style: TextStyle(
                fontSize: 24, // Larger text
                fontWeight: FontWeight.bold, // Bold text
                color: Colors.orangeAccent, // Change this color to your preference
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              hintText: 'Search...', controller: _controller, prefixIcon: Icons.search_outlined,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          CustomElevatedButton(text: "Clear Filter",onPressed: () {
            setState(() {
              selectedCategory = '';
              searchQuery = '';
            });
            medicineProvider.resetFilter();
          },),
          Expanded(
            child: ListView.separated(
              itemCount: categories.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.grey), // Add a line between each category
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(categories[index]),
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                    medicineProvider.filterByCategory(selectedCategory);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomElevatedButton(
              onPressed: () {
                // Navigate to the page for adding medicines
              },
              text: 'Add Medicine',
            ),
          ),
        ],
      ),
    );
  }
}
