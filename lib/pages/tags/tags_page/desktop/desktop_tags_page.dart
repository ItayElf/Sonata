import 'package:flutter/material.dart';
import 'package:sonata/components/desktop_navigation_drawer.dart';
import 'package:sonata/models/tag.dart';
import 'package:sonata/pages/tags/tags_edit/tags_edit.dart';

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
        floatingActionButton: getFloatingButton(context),
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

  Widget getFloatingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FloatingActionButton.extended(
        label: const Text(
          "New Label",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (ctx) => TagsEdit(
            onSave: (_, t) => onAdd(ctx, t),
            onDelete: (t) => onDelete(ctx, t),
          ),
        ),
        tooltip: "New Tag",
        icon: const Icon(Icons.add),
      ),
    );
  }
}
