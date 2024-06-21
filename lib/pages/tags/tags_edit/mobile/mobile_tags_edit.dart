import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:from_css_color/from_css_color.dart';

import 'package:sonata/models/tag.dart';

class MobileTagsEdit extends StatefulWidget {
  const MobileTagsEdit({
    super.key,
    this.oldTag,
    required this.onSave,
    required this.onDelete,
  });

  final Tag? oldTag;
  final Future Function(Tag? oldTag, Tag newTag) onSave;
  final Future Function(Tag oldTag) onDelete;

  @override
  State<MobileTagsEdit> createState() => _MobileTagsEditState();
}

class _MobileTagsEditState extends State<MobileTagsEdit> {
  final nameController = TextEditingController();
  late Color pickedColor;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.oldTag?.tag ?? "";
    pickedColor = fromCssColor(widget.oldTag?.color ?? "white");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(widget.oldTag == null ? "New Tag" : "Edit Tag"),
        actionsAlignment: widget.oldTag == null
            ? MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: "Tag Name"),
            ),
            const SizedBox(height: 16),
            ColorPicker(
              pickerColor: pickedColor,
              // paletteType: PaletteType.hueWheel,
              labelTypes: const [],
              onColorChanged: (c) {
                setState(() {
                  pickedColor = c;
                });
              },
            ),
          ],
        ),
        actions: [
          if (widget.oldTag != null)
            ElevatedButton(
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                await widget.onDelete(widget.oldTag!);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async {
              if (updatedTag.tag.isEmpty) return;
              await widget.onSave(widget.oldTag, updatedTag);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Tag get updatedTag => Tag(
        id: "",
        userId: "",
        tag: nameController.text,
        color: pickedColor.toCssString(),
      );
}
