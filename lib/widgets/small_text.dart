import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;

  double size;

  SmallText({Key? key, required this.text, this.size = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black54,
      ),
    );
  }
}
