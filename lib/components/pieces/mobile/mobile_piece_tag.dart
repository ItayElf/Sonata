import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:sonata/models/tag.dart';

class MobilePieceTag extends StatelessWidget {
  const MobilePieceTag({super.key, required this.tag, this.fontSize = 14});

  final Tag tag;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: fromCssColor(tag.color),
      ),
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Text(
        "#${tag.tag}",
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.black,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
