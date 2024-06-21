import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/mobile_navigation_bar.dart';
import 'package:sonata/components/tags/mobile_tag_card.dart';
import 'package:sonata/models/tag.dart';
import 'package:sonata/pages/tags/tags_edit/mobile/mobile_tags_edit.dart';
import 'package:sonata/state/global_state.dart';

class MobileTagsPage extends StatelessWidget {
  const MobileTagsPage({
    super.key,
    required this.onEdit,
    required this.onAdd,
    required this.onDelete,
  });

  final Future<bool> Function(BuildContext context, Tag? oldTag, Tag newTag)
      onEdit;
  final Future<bool> Function(BuildContext context, Tag newTag) onAdd;
  final Future<bool> Function(BuildContext context, Tag tag) onDelete;

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
                builder: (ctx) => MobileTagsEdit(
                  oldTag: tag,
                  onSave: (o, n) => onEdit(ctx, o, n),
                  onDelete: (t) => onDelete(ctx, t),
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
          builder: (ctx) => MobileTagsEdit(
            onSave: (_, t) => onAdd(ctx, t),
            onDelete: (t) => onDelete(ctx, t),
          ),
        ),
        tooltip: "New Tag",
        child: const Icon(Icons.add),
      ),
    );
  }
}
