import 'package:flutter/material.dart';

class DismissibleList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final void Function(int index, T item)? onDismissed;
  final String title;
  final void Function()? onAddClicked;
  final void Function(int index, T item)? onItemClicked;

  const DismissibleList({
    Key? key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.onDismissed,
    this.onAddClicked,
    this.onItemClicked,
  }) : super(key: key);

  Widget buildListTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title:",
          style: Theme.of(context).textTheme.headline6,
        ),
        onAddClicked != null
            ? IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: onAddClicked,
              )
            : const SizedBox(height: 30),
      ],
    );
  }

  Widget buildList(BuildContext context) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: const Text("No items to display"),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: items.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final listItem = items[index];
        return Dismissible(
          key: Key(listItem.toString()),
          direction: onDismissed != null
              ? DismissDirection.startToEnd
              : DismissDirection.none,
          onDismissed: (_) => onDismissed?.call(index, listItem),
          background: Container(color: Colors.red),
          child: InkWell(
            onTap: () => onItemClicked?.call(index, listItem),
            child: SizedBox(
                width: double.infinity,
                child: itemBuilder(context, index, listItem)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildListTitle(context),
        buildList(context),
      ],
    );
  }
}