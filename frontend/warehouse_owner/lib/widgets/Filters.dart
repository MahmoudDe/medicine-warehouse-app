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
  List<Medicine> medicines = [];
  List<Medicine> foundMedicines = [];
  final TextEditingController _controller = TextEditingController();
  String selectedCategory = '';
  String searchQuery = '';
  List<String> categories = [];
  List<String> filteredCategories = [];

  void searchCategories(String query) async {
    final medicineProvider =
        Provider.of<MedicineProvider>(context, listen: false);
    List<String> categories = await medicineProvider.getCategories();
    List<String> matchingCategories = categories.where((category) {
      return category.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredCategories = matchingCategories;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    _controller.addListener(() {
      searchCategories(_controller.text);
    });
  }

  void fetchCategories() async {
    final medicineProvider =
        Provider.of<MedicineProvider>(context, listen: false);
    categories = await medicineProvider.getCategories();
    setState(() {
      filteredCategories = categories;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicineProvider = Provider.of<MedicineProvider>(context);
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Categories:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              hintText: 'Search...',
              controller: _controller,
              prefixIcon: Icons.search_outlined,
              onChanged: (value) {
                searchCategories(value);
              },
            ),
          ),
          CustomElevatedButton(
            text: "Clear Filter",
            onPressed: () {
              setState(() {
                selectedCategory = '';
                searchQuery = '';
                filteredCategories = categories;
              });
              medicineProvider.resetFilter();
            },
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filteredCategories.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(color: Colors.grey),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredCategories[index]),
                  onTap: () {
                    setState(() {
                      selectedCategory = filteredCategories[index];
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FutureBuilder<List<Medicine>>(
                          future: medicineProvider
                              .getMedicinesByCategory(selectedCategory),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Medicine>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              var medicines = snapshot.data;

                              var medicineCards = medicines!
                                  .map((medicine) =>
                                      MedicineCard(medicine: medicine))
                                  .toList();
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: GridView.builder(
                                  itemCount: medicineCards.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return medicineCards[index];
                                  },
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
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
