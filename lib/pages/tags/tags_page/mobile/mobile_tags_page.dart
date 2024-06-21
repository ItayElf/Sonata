import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sonata/components/mobile_navigation_bar.dart';
import 'package:sonata/components/tags/mobile_tag_card.dart';
import 'package:sonata/state/global_state.dart';

class MobileTagsPage extends StatelessWidget {
  const MobileTagsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MobileNavigationBar(selectedIndex: 1),
        floatingActionButton: getFloatingButton(),
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
        final sortedTags = List.from(state.tags);
        sortedTags.sort((a, b) => a.tag.compareTo(b.tag));
        return Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: 144 / 39,
            children: sortedTags
                .map((tag) => MobileTagCard(tag: tag, onEdit: () {}))
                .toList(),
          ),
        );
      },
    );
  }

  Padding getFloatingButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: "New Tag",
        child: const Icon(Icons.add),
      ),
    );
  }
}
