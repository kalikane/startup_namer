import 'package:flutter/material.dart';
import 'DataShared.dart';

// Class Widget qui gère l'affichage de la liste des favoris
class ListSavedScreen extends StatefulWidget {
  const ListSavedScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListSavedScreenState();
}

class _ListSavedScreenState extends State<ListSavedScreen> {
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    final tiles = DataShared.saved.map(
      (pair) {
        return Card(
          margin: const EdgeInsets.all(5),
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Text(
              pair.asPascalCase,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              textAlign: TextAlign.center,
              
            )),
            Expanded(
                child: IconButton(
              iconSize: 30,
              icon: const Icon(Icons.delete),
              color: Colors.pink,
              alignment: Alignment.center,
              onPressed: (() {
                setState(() {
                  DataShared.saved.remove(pair);
                });
              }),
            ))
          ],
        ));
      },
    );
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(
          
            context: context,
            tiles: tiles,
            color: Colors.pink,
          ).toList()
        : <Widget>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
      backgroundColor: Colors.grey,
    );
  }
}
