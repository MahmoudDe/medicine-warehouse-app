// filters.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_owner_app/widgets/TextField.dart';
import '../Provider/Medicine_Provider.dart';
import '../classes/Medicine.dart';
import 'Button.dart';
import 'MedicineCard.dart';


class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  List<Medicine> medicines = []; // Add this line

  final TextEditingController _controller = TextEditingController();
  String selectedCategory = '';
  String searchQuery = '';
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    final medicineProvider = Provider.of<MedicineProvider>(context, listen: false);
    categories = await medicineProvider.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final medicineProvider = Provider.of<MedicineProvider>(context);
    final filteredCategories = categories.where((category) => category.contains(searchQuery)).toList();
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FutureBuilder<List<Medicine>>(
                          future: medicineProvider.getMedicinesByCategory(selectedCategory),
                          builder: (BuildContext context, AsyncSnapshot<List<Medicine>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator()); // Show a loading indicator while waiting for the server
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}'); // Show an error message if an error occurred
                            } else {
                              var medicines = snapshot.data;
                              // Create a list of MedicineCard widgets for each medicine
                              var medicineCards = medicines!.map((medicine) => MedicineCard(medicine: medicine)).toList();
                              // Display the medicine cards in a GridView
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: GridView.builder(
                                  itemCount: medicineCards.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return medicineCards[index];
                                  },
                                  // Add gridDelegate parameter to control the layout of the grid
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4, // Change this number to control the number of items in a row
                                  ),
                                ),
                              );
                            }
                          },
                        );

                      },
                    );
                  },
                );

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/make_category');
              },
              text: 'Add Category',
            ),
          ),
        ],
      ),
    );
  }
}
