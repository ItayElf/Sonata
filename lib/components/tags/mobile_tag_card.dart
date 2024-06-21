import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:sonata/models/tag.dart';

class MobileTagCard extends StatelessWidget {
  const MobileTagCard({super.key, required this.tag, required this.onEdit});

  final Tag tag;
  final void Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: tagColor(),
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 4,
                spreadRadius: 0,
                offset: Offset(0, 2)),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "#${tag.tag}",
                style:
                    const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            InkWell(onTap: onEdit, child: const Icon(Icons.edit_outlined))
          ],
        ),
      ),
    );
  }

  Color tagColor() {
    final color = fromCssColor(tag.color);
    if (color.alpha == 0) {
      return Colors.white;
    }
    return color;
  }
}
