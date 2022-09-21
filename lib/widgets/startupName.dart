import 'package:flutter/material.dart';

class StartupNameWidget extends StatelessWidget {
  const StartupNameWidget(
      {Key? key,
      required this.alreadySaved,
      required this.name,
      required this.setAsFavorite})
      : super(key: key);

  final bool alreadySaved;
  final String name;
  final VoidCallback setAsFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
          semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
        ),
        onTap: setAsFavorite,
      ),
    );
  }
}
