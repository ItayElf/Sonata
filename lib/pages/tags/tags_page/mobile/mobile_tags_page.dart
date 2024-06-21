import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/communication/tags.dart';
import 'package:sonata/components/mobile_navigation_bar.dart';
import 'package:sonata/components/tags/mobile_tag_card.dart';
import 'package:sonata/models/tag.dart';
import 'package:sonata/pages/tags/tags_edit/mobile/mobile_tags_edit.dart';
import 'package:sonata/state/global_state.dart';

class MobileTagsPage extends StatelessWidget {
  const MobileTagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MobileNavigationBar(selectedIndex: 1),
        floatingActionButton: getFloatingButton(context),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tags",
                style:
                    GoogleFonts.greatVibes(fontSize: 51, letterSpacing: -0.5),
              ),
              const SizedBox(height: 40),
              getTagsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Consumer<GlobalState> getTagsGrid() {
    return Consumer<GlobalState>(
      builder: (context, state, child) {
        return Expanded(
          child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 144 / 39,
              children: getTileCards(context, state.tags)),
        );
      },
    );
  }

  List<Widget> getTileCards(BuildContext context, Iterable<Tag> tags) {
    final sortedTags = List.from(tags);
    sortedTags.sort((a, b) => a.tag.compareTo(b.tag));
    return sortedTags
        .map((tag) => MobileTagCard(
              tag: tag,
              onEdit: () => showDialog(
                context: context,
                builder: (_) => MobileTagsEdit(
                  oldTag: tag,
                  onSave: (o, n) => onEdit(context, o, n),
                  onDelete: (t) => onDelete(context, t),
                ),
              ),
            ))
        .toList();
  }

  Padding getFloatingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => MobileTagsEdit(
            onSave: (_, t) => onAdd(context, t),
            onDelete: (t) => onDelete(context, t),
          ),
        ),
        tooltip: "New Tag",
        child: const Icon(Icons.add),
      ),
    );
  }

  Future onEdit(BuildContext context, Tag? oldTag, Tag newTag) async {
    if (oldTag == null) return;
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await editTagRequest(oldTag, newTag, state.token);
    if (result.isError) {
      showError(result.error!);
      return;
    }
    state.editTag(oldTag, result.data!);
  }

  Future onAdd(BuildContext context, Tag newTag) async {
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await addTagRequest(newTag, state.token);
    if (result.isError) {
      showError(result.error!);
      return;
    }
    state.addTag(result.data!);
  }

  Future onDelete(BuildContext context, Tag tag) async {
    final state = Provider.of<GlobalState>(context, listen: false);
    final result = await deleteTagRequest(tag, state.token);
    if (result.isError) {
      showError(result.error!);
      return;
    }
    state.deleteTag(tag);
  }

  void showError(String error) {
    print(error);
  }
}
