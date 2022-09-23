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
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          pair.asPascalCase,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.start,
                        ))),
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: IconButton(
                          iconSize: 30,
                          icon: const Icon(Icons.delete),
                          color: Colors.pink,
                          alignment: Alignment.centerRight,
                          onPressed: (() {
                            setState(() {
                              DataShared.saved.remove(pair);
                            });
                          }),
                        )))
              ],
            ));
      },
    );
    final divided = tiles.isNotEmpty
        ? tiles.toList()
        : <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: const Text('Aucun favori ajouté',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
                Container(
                    height: 250,
                    margin: const EdgeInsets.all(50),
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
      backgroundColor: Colors.grey,
    );
  }
}
