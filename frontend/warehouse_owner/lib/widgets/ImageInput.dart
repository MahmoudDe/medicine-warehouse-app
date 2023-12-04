import 'dart:html';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ImageInput extends StatefulWidget {
  final ValueChanged<String> onImagePicked;

  ImageInput({required this.onImagePicked});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Image? _imageWidget;

  void _pickImage() async {
    final mediaInfo = await ImagePickerWeb.getImageInfo;
    if (mediaInfo != null) {
      setState(() {
        _imageWidget = Image.memory(mediaInfo.data!);
      });
      widget.onImagePicked(mediaInfo.fileName!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _imageWidget != null
              ? _imageWidget
              : Text('No image selected'),
          alignment: Alignment.center,
        ),
        TextButton.icon(
          icon: Icon(Icons.image),
          label: Text('Select Image'),
          onPressed: _pickImage,
        ),
        SizedBox(height: 30)
      ],
    );
  }
}