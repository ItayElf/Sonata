import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sonata/components/mobile_navigation_bar.dart';

class MobilePiecesPage extends StatefulWidget {
  const MobilePiecesPage({super.key});

  @override
  State<MobilePiecesPage> createState() => _MobilePiecesPageState();
}

class _MobilePiecesPageState extends State<MobilePiecesPage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MobileNavigationBar(selectedIndex: 0),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pieces",
                style:
                    GoogleFonts.greatVibes(fontSize: 51, letterSpacing: -0.5),
              ),
              getSearchRow(),
              const SizedBox(height: 16),
              getLayoutRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSearchRow() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
              hintText: "Search",
            ),
            controller: searchController,
          ),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: () {},
          child: const Icon(Icons.filter_alt_outlined),
        )
      ],
    );
  }

  Widget getLayoutRow() {
    return Row(
      children: [
        const Expanded(
            child: Text(
          "Results",
          style: TextStyle(fontSize: 16),
        )),
        InkWell(
          onTap: () {},
          child: const Icon(Icons.grid_view_outlined),
        ),
      ],
    );
  }
}
