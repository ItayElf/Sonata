import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonata/communication/tags.dart';
import 'package:sonata/models/tag.dart';
import 'package:sonata/pages/responsive_page.dart';
import 'package:sonata/pages/tags/tags_page/desktop/desktop_tags_page.dart';
import 'package:sonata/pages/tags/tags_page/mobile/mobile_tags_page.dart';
import 'package:sonata/state/global_state.dart';

class TagsPage extends StatelessWidget {
  const TagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      mobile: MobileTagsPage(
        onEdit: onEdit,
        onAdd: onAdd,
        onDelete: onDelete,
      ),
      desktop: DesktopTagsPage(
        onEdit: onEdit,
        onAdd: onAdd,
        onDelete: onDelete,
      ),
    );
  }

  Future<bool> onEdit(BuildContext context, Tag? oldTag, Tag newTag) async {
    if (oldTag == null) return true;
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await editTagRequest(oldTag, newTag, state.token);
    if (result.isError) {
      if (context.mounted) {
        showError(context, result.error!);
      }
      return false;
    }
    state.editTag(oldTag, result.data!);
    return true;
  }

  Future<bool> onAdd(BuildContext context, Tag newTag) async {
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await addTagRequest(newTag, state.token);
    if (result.isError) {
      if (context.mounted) {
        showError(context, result.error!);
      }
      return false;
    }
    state.addTag(result.data!);
    return true;
  }

  Future<bool> onDelete(BuildContext context, Tag tag) async {
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await deleteTagRequest(tag, state.token);
    if (result.isError) {
      if (context.mounted) {
        showError(context, result.error!);
      }
      return false;
    }
    state.deleteTag(tag);
    return true;
  }

  void showError(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(
          error,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              "Ok",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        ],
      ),
    );
  }
}
