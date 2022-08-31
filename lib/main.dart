import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import './DataShared.dart';
import 'ListSavedScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.pink,
        ),
      ),
      home: const RandomWords(),
    );
  }
}

// Class widget qui gère l'affichage de la liste des startups.
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _biggerFont = const TextStyle(fontSize: 18);

  static final _RandomWordsState _instance = _RandomWordsState._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory _RandomWordsState() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  _RandomWordsState._internal() {
    // initialization logic
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;

          if (index >= DataShared.suggestions.length) {
            DataShared.suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved =  DataShared.saved.contains(DataShared.suggestions[index]);

          return ListTile(
            title: Text(
              DataShared.suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  DataShared.saved.remove((DataShared.suggestions[index]));
                } else {
                  DataShared.saved.add(DataShared.suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  void  _pushSaved() async{
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (context) => const ListSavedScreen()),
    );
    setState(() {
    });
  }

}
