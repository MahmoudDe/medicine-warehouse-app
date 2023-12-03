import 'package:flutter/material.dart';

import '../Server/server.dart';
import 'BorderButton.dart';
import 'TextField.dart';

class CategoryInput extends StatefulWidget {
  @override
  _CategoryInputState createState() => _CategoryInputState();
}

class _CategoryInputState extends State<CategoryInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showDialog();
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Category Name'),
          content: CustomTextField(
            controller: _controller,
            hintText: 'Category Name',
            prefixIcon: Icons.category,
          ),
          actions: <Widget>[
            BorderButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/home');
              },
            ),
            BorderButton(
              text: 'Submit',
              onPressed: () async {
                // Call the addCategory method here
                await Server().addCategory({'name': _controller.text});

                // Clear the text field and show a success message
                _controller.clear();
                Navigator.pushNamed(context, '/home');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Category created successfully')),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
