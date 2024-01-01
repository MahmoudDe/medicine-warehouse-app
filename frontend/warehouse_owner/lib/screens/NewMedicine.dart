import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Server/server.dart';
import '../classes/Medicine.dart';
import '../widgets/BorderButton.dart';
import '../widgets/DateInput.dart';
import '../widgets/ImageInput.dart';
import '../widgets/OptionalField.dart';
import '../widgets/TextField.dart';


class NewMedicineForm extends StatefulWidget {
  @override
  _NewMedicineFormState createState() => _NewMedicineFormState();
}

class _NewMedicineFormState extends State<NewMedicineForm> {
  final _formKey = GlobalKey<FormState>();
  final _medicineData = {
    'categories_id': '',
    'scientific_name': '',
    'commercial_name': '',
    'category': '',
    'manufacturer': '',
    'quantity': '',
    'expiry_date': '',
    'price': '',
    'image': '',
  };

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Form data:');
      _medicineData.forEach((key, value) {
        print('$key: $value');
      });
      Server server = Server();
      try {
        await server.addMedicine(_medicineData);
        // Show success alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success!'),
              content: Text('Medicine added successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to the previous screen or perform any other action
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } catch (error) {
        // Show error alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to add medicine: $error'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                      OptionalTextField(
                        controller: TextEditingController(),
                        hintText: 'Categories ID',
                        onChanged: (value) {
                          _medicineData['categories_id'] = value;
                        },
                      ),
                      OptionalTextField(
                        controller: TextEditingController(),
                        hintText: 'Scientific Name',
                        onChanged: (value) {
                          _medicineData['scientific_name'] = value;
                        },
                      ),
                      OptionalTextField(
                        controller: TextEditingController(),
                        hintText: 'Commercial Name',
                        onChanged: (value) {
                          _medicineData['commercial_name'] = value;
                        },
                      ),
                      OptionalTextField(
                        controller: TextEditingController(),
                        hintText: 'Category',
                        onChanged: (value) {
                          _medicineData['category'] = value;
                        },
                      ),
                      OptionalTextField(
                        controller: TextEditingController(),
                        hintText: 'Manufacturer',
                        onChanged: (value) {
                          _medicineData['manufacturer'] = value;
                        },
                      ),
                      OptionalTextField(
                        controller: TextEditingController(),
                        hintText: 'Quantity',
                        onChanged: (value) {
                          _medicineData['quantity'] = value;
                        },
                      ),
                      DateInput(
                        onChanged: (value) {
                          _medicineData['expiry_date'] = value;
                        },
                      ),
                      OptionalTextField(
                        controller: TextEditingController(),
                        hintText: 'Price',
                        onChanged: (value) {
                          _medicineData['price'] = value;
                        },
                      ),
                      ImageInput(
                        onImagePicked: (value) {
                          _medicineData['image'] = value;
                        },
                      ),
                      BorderButton(
                        onPressed: _submitForm,
                        text: "Submit",
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
