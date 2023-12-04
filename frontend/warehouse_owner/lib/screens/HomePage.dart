// HomeScreen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade800,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        title: Text('Home Page', style: GoogleFonts.lato(color: Colors.white, fontSize: 22)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications), // Icon for notifications
                  onPressed: () {
                    // Handle notification icon press
                  },
                ),
            IconButton(
              icon: Icon(Iconsax.activity), // Icon for incoming orders
              onPressed: () {
                Navigator.pushNamed(context, '/orders');
                // Handle incoming orders icon press
              },
            ),
                    ],
                  ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
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
                      child: CustomTextField(hintText: 'search..', controller: _controller, prefixIcon: Icons.search_rounded),
                    ),
                  ),
                  Consumer<MedicineProvider>(
                    builder: (context, medicineProvider, child) {
                      return FutureBuilder<List<Medicine>>(
                        future: medicineProvider.getMedicines(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator(color: Colors.orangeAccent,);
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<Medicine> medicines = snapshot.data!;
                            return Flexible(
                              child: FutureBuilder<List<Medicine>>(
                                future: medicineProvider.getMedicines(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    List<Medicine> medicines = snapshot.data!;
                                    return GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4, // Change this number based on your design
                                      ),
                                      itemCount: medicines.length,
                                      itemBuilder: (context, index) {
                                        return MedicineCard(medicine: medicines[index]);
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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Icon(Iconsax.add_circle, color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Add Medicine", style: TextStyle(
                    color: Colors.white
                  ),),
                ),

              ],
            ),
            backgroundColor: Colors.cyan.shade800,
            onPressed: () {
              Navigator.pushNamed(context, '/make_medicine');
            },
          ),
        ),
      ),
    );
  }
}
