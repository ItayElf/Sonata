import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:sonata/models/tag.dart';
import 'package:textfield_tags/textfield_tags.dart';

class PieceTagsFilter extends StatefulWidget {
  const PieceTagsFilter({
    super.key,
    required this.notifier,
    required this.tags,
  });

  final ValueNotifier<List<Tag>> notifier;
  final List<Tag> tags;

  @override
  State<PieceTagsFilter> createState() => _PieceTagsFilterState();
}

class _PieceTagsFilterState extends State<PieceTagsFilter> {
  final _tagController = DynamicTagController<DynamicTagData<Tag>>();
  late List<DynamicTagData<Tag>> _tagOptions;

  @override
  void initState() {
    _tagOptions = widget.tags.map((e) => DynamicTagData(e.tag, e)).toList();
    super.initState();
  }

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<DynamicTagData<Tag>>(
      displayStringForOption: (e) => e.tag,
      optionsBuilder: (value) {
        if (value.text == "") return const [];
        return _tagOptions.where((element) =>
            element.tag.toLowerCase().contains(value.text.toLowerCase()));
      },
      optionsViewBuilder: (context, onSelected, options) => ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) => Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            color: fromCssColor(options.elementAt(index).data.color).alpha == 0
                ? Colors.white
                : fromCssColor(options.elementAt(index).data.color),
            child: TextButton(
              onPressed: () => onSelected(options.elementAt(index)),
              child: Text(
                textAlign: TextAlign.left,
                "#${options.elementAt(index).tag}",
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextFieldTags<DynamicTagData<Tag>>(
        textfieldTagsController: _tagController,
        textEditingController: textEditingController,
        focusNode: focusNode,
        textSeparators: const [' ', ','],
        validator: (tag) {
          if (_tagController.getTags!
              .any((element) => element.tag == tag.tag)) {
            return "Already added";
          }
          return null;
        },
        initialTags:
            widget.notifier.value.map((e) => DynamicTagData(e.tag, e)).toList(),
        inputFieldBuilder: (context, inputFieldValues) => TextField(
          controller: inputFieldValues.textEditingController,
          focusNode: inputFieldValues.focusNode,
          decoration: InputDecoration(
            isDense: true,
            helperText: "Tags to filter",
            errorText: inputFieldValues.error,
            prefixIconConstraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.74,
            ),
            prefixIcon: inputFieldValues.tags.isEmpty
                ? null
                : SingleChildScrollView(
                    controller: inputFieldValues.tagScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: inputFieldValues.tags
                          .map((e) => getTagContainer(inputFieldValues, e))
                          .toList(),
                    ),
                  ),
          ),
          onSubmitted: (value) {
            final tags = widget.tags.where((element) => element.tag == value);
            if (tags.length == 1) {
              inputFieldValues
                  .onTagSubmitted(DynamicTagData(value, tags.first));
              widget.notifier.value.add(tags.first);
            }
            inputFieldValues.focusNode.requestFocus();
          },
        ),
      ),
      onSelected: (option) {
        final tags = widget.tags.where((element) => element.tag == option.tag);
        final isAdded =
            _tagController.getTags?.where((e) => e.tag == option.tag).isEmpty ??
                false;
        if (tags.length == 1 && isAdded) {
          _tagController.onTagSubmitted(DynamicTagData(option.tag, tags.first));
          widget.notifier.value.add(tags.first);
        }
      },
    );
  }

  Container getTagContainer(
    InputFieldValues<DynamicTagData<Tag>> inputFieldValues,
    DynamicTagData<Tag> e,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: fromCssColor(e.data.color),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      padding: const EdgeInsets.fromLTRB(2, 0, 4, 0),
      child: Row(
        children: [
          Text(
            "#${e.tag}",
            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
          ),
          const SizedBox(width: 4.0),
          InkWell(
            child: const Icon(
              Icons.cancel,
              size: 14.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onTap: () {
              inputFieldValues.onTagRemoved(e);
              widget.notifier.value.remove(e.data);
            },
          )
        ],
      ),
    );
  }
}
