import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

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
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>[];

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
  void initState() {
    // TODO: implement initState
    super.initState();
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

          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved = _saved.contains(_suggestions[index]);

          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
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
                  _saved.remove((_suggestions[index]));
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) =>  ListSavedScreen(savedList: _saved)),
    );
  }

void Refresh(WordPair pair){

  setState(() {
    _RandomWordsState()._saved.remove(pair);
  });
}

}

// Class Widget qui gère l'affichage de la liste des favoris
class ListSavedScreen extends StatefulWidget {
   ListSavedScreen({Key? key, required this.savedList}) : super(key: key);
  
  final List<WordPair> savedList ;

  @override
  State<StatefulWidget> createState() => _ListSavedScreenState();
}

class _ListSavedScreenState extends State<ListSavedScreen> {
  final _biggerFont = const TextStyle(fontSize: 18);
  final _RandomWordsState r = _RandomWordsState();
  @override
  Widget build(BuildContext context) {
     final tiles = widget.savedList.map(
      (pair) {
        return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          pair.asPascalCase,
          style: _biggerFont,
          textAlign: TextAlign.start,
        ),
        IconButton(
          iconSize: 30,
          icon: const Icon(Icons.remove),
          color: Colors.pink,
          alignment: Alignment.centerLeft,
          onPressed: (() {
           
           setState(() {
             widget.savedList.remove(pair);
             _RandomWordsState().Refresh(pair);
           });
          }),
        )
      ],
    );
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
    );
  }
}
