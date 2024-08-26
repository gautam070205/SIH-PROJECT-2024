import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  // ignore: use_super_parameters
  const ReusableText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      overflow: TextOverflow.visible, // Make overflow visib
      textAlign: TextAlign.left,
      style: style,
    );
  }
}
