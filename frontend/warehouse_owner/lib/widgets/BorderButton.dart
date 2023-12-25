import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  BorderButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width/5,
      height: screenSize.height/18,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStatePropertyAll(0.1),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return Colors.orangeAccent;
              return Colors.white;
            },
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.orange),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.orange, fontSize: 18),
        ),
      ),
    );
  }
}
