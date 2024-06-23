import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/desktop_navigation_drawer.dart';
import 'package:sonata/components/tags/mobile_tag_card.dart';
import 'package:sonata/models/tag.dart';
import 'package:sonata/pages/tags/tags_edit/tags_edit.dart';
import 'package:sonata/state/global_state.dart';
import 'package:sonata/state/state_guard.dart';

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
    return StateGuard(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: getFloatingButton(context),
          body: Row(
            children: [
              const IntrinsicWidth(
                child: DesktopNavigationDrawer(
                  selectedIndex: 1,
                ),
              ),
              const VerticalDivider(thickness: 0, width: 0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(72, 48, 72, 0),
                  child: Column(
                    children: [
                      Text(
                        "Tags",
                        style: GoogleFonts.greatVibes(
                            fontSize: 89, letterSpacing: -0.5),
                      ),
                      const SizedBox(height: 40),
                      getTagsGrid(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFloatingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FloatingActionButton.extended(
        label: const Text(
          "New Tag",
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

  Consumer<GlobalState> getTagsGrid() {
    return Consumer<GlobalState>(
      builder: (context, state, child) {
        return Expanded(
          child: GridView.count(
              crossAxisCount: 6,
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
                builder: (ctx) => TagsEdit(
                  oldTag: tag,
                  onSave: (o, n) => onEdit(ctx, o, n),
                  onDelete: (t) => onDelete(ctx, t),
                ),
              ),
            ))
        .toList();
  }
}
