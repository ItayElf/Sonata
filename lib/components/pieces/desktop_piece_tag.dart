import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:sonata/models/tag.dart';

class DesktopPieceTag extends StatelessWidget {
  const DesktopPieceTag({super.key, required this.tag});

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: fromCssColor(tag.color),
      ),
      child: Text(
        "#${tag.tag}",
        style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
      ),
    );
  }
}
