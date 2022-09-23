import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_namer/widgets/startupName.dart';
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
      backgroundColor: Colors.grey,
      body: ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;

          if (index >= DataShared.suggestions.length) {
            DataShared.suggestions.addAll(generateWordPairs().take(10));
          }

          final alreadySaved =
              DataShared.saved.contains(DataShared.suggestions[index]);

          return StartupNameWidget(
              alreadySaved: alreadySaved,
              name: DataShared.suggestions[index].asPascalCase,
              setAsFavorite: () {
                setState(() {
                  if (alreadySaved) {
                    DataShared.saved.remove((DataShared.suggestions[index]));
                  } else {
                    DataShared.saved.add(DataShared.suggestions[index]);
                  }
                });
              });
        },
      ),
    );
  }

  void _pushSaved() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) => const ListSavedScreen()),
    );
    // S'il y'a eu une 
    setState(() {});
  }
}
