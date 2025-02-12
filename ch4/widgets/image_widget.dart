import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/lab_instagram.jpg',
      width: double.infinity,
    );
  }
}