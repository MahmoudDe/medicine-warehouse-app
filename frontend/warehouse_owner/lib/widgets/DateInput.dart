import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warehouse_owner_app/widgets/BorderButton.dart';

class DateInput extends StatefulWidget {
final ValueChanged<String> onChanged;

DateInput({required this.onChanged});

@override
_DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  DateTime _selectedDate = DateTime.now();
  final _dateController = TextEditingController();

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      final String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
      _dateController.text = formattedDate;
      widget.onChanged(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: 'Expiry Date',
            ),
          ),
        ),

        SizedBox(width: 10),
        BorderButton(
          onPressed: _selectDate,
          text: 'Select Expiry Date',
        ),
      ],
    );
  }
}
