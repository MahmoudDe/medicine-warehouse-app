import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_owner_app/Server/server.dart';
import 'package:warehouse_owner_app/screens/NavBar.dart';
import 'package:warehouse_owner_app/widgets/Filters.dart';
import 'package:warehouse_owner_app/widgets/TextField.dart';
import '../Provider/Medicine_Provider.dart';
import '../classes/Medicine.dart';
import '../widgets/MedicineCard.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Medicine> foundMedicines = [];
  final TextEditingController _controller = TextEditingController();

  void searchMedicines(String query) async {
    List<Medicine> medicines =
        await Provider.of<MedicineProvider>(context, listen: false)
            .getMedicines();
    List<Medicine> matchingMedicines;

    if (query.isEmpty) {
      matchingMedicines = medicines;
    } else {
      matchingMedicines = medicines.where((medicine) {
        return medicine.scientificName
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            medicine.category.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    setState(() {
      foundMedicines = matchingMedicines;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      searchMedicines(_controller.text);
    });
    searchMedicines('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        title: Text('Home Page',
            style: GoogleFonts.lato(color: Colors.white, fontSize: 22)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    // Handle notification icon press
                  },
                ),
                IconButton(
                  icon: const Icon(Iconsax.activity),
                  onPressed: () {
                    Navigator.pushNamed(context, '/orders');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Filters(),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomTextField(
                        hintText: 'search..',
                        controller: _controller,
                        prefixIcon: Icons.search_rounded,
                        onChanged: (value) {
                          searchMedicines(value);
                        },
                      ),
                    ),
                  ),
                  Consumer<MedicineProvider>(
                    builder: (context, medicineProvider, child) {
                      return FutureBuilder<List<Medicine>>(
                        future: medicineProvider.getMedicines(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: Colors.orangeAccent,
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Medicine> medicines = snapshot.data!;
                            return Flexible(
                              child: FutureBuilder<List<Medicine>>(
                                future: Server().getMedicines(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    List<Medicine> medicines = snapshot.data!;
                                    return GridView.builder(
                                      itemCount: medicines.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                      ),
                                      itemBuilder: (context, index) {
                                        if (index < foundMedicines.length) {
                                          return MedicineCard(
                                              medicine: foundMedicines[index]);
                                        } else {
                                          return null;
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: Container(
          width: 200,
          child: FloatingActionButton(
            backgroundColor: Colors.cyan.shade800,
            onPressed: () {
              Navigator.pushNamed(context, '/make_medicine');
            },
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Icon(
                    Iconsax.add_circle,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Add Medicine",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
