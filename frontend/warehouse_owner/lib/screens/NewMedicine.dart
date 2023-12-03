import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/Medicine_Provider.dart';
import '../Server/server.dart';
import '../classes/Medicine.dart';
import '../widgets/BorderButton.dart';
import '../widgets/TextField.dart';

class NewMedicineForm extends StatefulWidget {
  @override
  _NewMedicineFormState createState() => _NewMedicineFormState();
}

class _NewMedicineFormState extends State<NewMedicineForm> {
  final _formKey = GlobalKey<FormState>();
  final _scientificNameController = TextEditingController();
  final _commercialNameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _quantityController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _priceController = TextEditingController();
  final _slugController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    return Scaffold(
      appBar:  AppBar(
      backgroundColor: Colors.cyan.shade800,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.white, size: 28),
      title: Text('Add a new medicine', style: GoogleFonts.lato(color: Colors.white, fontSize: 22)),
    ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width/2,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                        controller: _scientificNameController,
                        hintText: 'Scientific Name',
                        prefixIcon: Icons.medical_services,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _commercialNameController,
                        hintText: 'Commercial Name',
                        prefixIcon: Icons.medical_services,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _categoryController,
                        hintText: 'Category',
                        prefixIcon: Icons.category,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _manufacturerController,
                        hintText: 'Manufacturer',
                        prefixIcon: Icons.business,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _quantityController,
                        hintText: 'Quantity',
                        prefixIcon: Icons.format_list_numbered,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _expiryDateController,
                        decoration: InputDecoration(
                          hintText: 'Expiry Date',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening the onscreen keyboard
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 5),
                          );
                          if (pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format the date as you want
                            _expiryDateController.text = formattedDate;
                          }
                        },
                      ),

                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _priceController,
                        hintText: 'Price',
                        prefixIcon: Icons.attach_money,
                      ),
                      SizedBox(height: 20),
                      BorderButton(
                        text: 'Create',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              // Handle form submission
                              String scientificName = _scientificNameController.text;
                              String commercialName = _commercialNameController.text;
                              String category = _categoryController.text;
                              String manufacturer = _manufacturerController.text;
                              int quantity = int.parse(_quantityController.text);

                              // Use a date picker for the expiry date
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 5),
                              );

                              // Check if a date was selected
                              if (pickedDate != null) {
                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format the date as you want
                                _expiryDateController.text = formattedDate;
                              } else {
                                print('No date selected');
                                return;
                              }

                              double price = double.parse(_priceController.text);

                              Map<String, dynamic> medicine = {
                                'scientific_name': scientificName,
                                'commercial_name': commercialName,
                                'category': category,
                                'manufacturer': manufacturer,
                                'quantity': quantity,
                                'expiry_date': _expiryDateController.text,
                                'price': price,
                              };

                              Server server = Server();
                              await server.addMedicine(medicine);

                            } catch (e) {
                              print('Failed to create medicine: $e');
                            }
                          }
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
