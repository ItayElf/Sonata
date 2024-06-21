import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:sonata/components/future_elevated_button.dart';

import 'package:sonata/models/tag.dart';

class TagsEdit extends StatefulWidget {
  const TagsEdit({
    super.key,
    this.oldTag,
    required this.onSave,
    required this.onDelete,
  });

  final Tag? oldTag;
  final Future<bool> Function(Tag? oldTag, Tag newTag) onSave;
  final Future<bool> Function(Tag oldTag) onDelete;

  @override
  State<TagsEdit> createState() => _TagsEditState();
}

class _TagsEditState extends State<TagsEdit> {
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
    return AlertDialog(
      title: Text(widget.oldTag == null ? "New Tag" : "Edit Tag"),
      actionsAlignment: widget.oldTag == null
          ? MainAxisAlignment.end
          : MainAxisAlignment.spaceBetween,
      content: SingleChildScrollView(
        child: Column(
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
      ),
      actions: [
        if (widget.oldTag != null)
          FutureElevatedButton(
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () async {
              final shouldClose = await widget.onDelete(widget.oldTag!);
              if (shouldClose && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        FutureElevatedButton(
          child: const Text('Save'),
          onPressed: () async {
            if (updatedTag.tag.isEmpty) return;
            final shouldClose = await widget.onSave(widget.oldTag, updatedTag);
            if (shouldClose && context.mounted) {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Tag get updatedTag => Tag(
        id: "",
        userId: "",
        tag: nameController.text,
        color: pickedColor.toCssString(),
      );
}
