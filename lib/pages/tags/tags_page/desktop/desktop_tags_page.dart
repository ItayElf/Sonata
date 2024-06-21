import 'package:flutter/material.dart';
import 'package:sonata/components/desktop_navigation_drawer.dart';
import 'package:sonata/models/tag.dart';

class DesktopTagsPage extends StatelessWidget {
  const DesktopTagsPage(
      {super.key,
      required this.onEdit,
      required this.onAdd,
      required this.onDelete});

  final Future<bool> Function(BuildContext context, Tag? oldTag, Tag newTag)
      onEdit;
  final Future<bool> Function(BuildContext context, Tag newTag) onAdd;
  final Future<bool> Function(BuildContext context, Tag tag) onDelete;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            IntrinsicWidth(
              child: DesktopNavigationDrawer(
                selectedIndex: 1,
              ),
            ),
            const VerticalDivider(thickness: 0, width: 0),
            Expanded(child: Placeholder()),
          ],
        ),
      ),
    );
  }
}
