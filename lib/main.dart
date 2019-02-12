import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());


//Stateless widgets are immutable, meaning that their properties can’t change—all values are final.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final wordPair = WordPair.random();

    return new MaterialApp(

      home: RandomWords(),

      theme: new ThemeData(
        primaryColor: Colors.white,
      ),

    );
  }
}

//Most of the app’s logic and state resides here—it maintains the state for the
// RandomWords widget. This class saves the generated word pairs, which grows
// infinitely as the user scrolls, and favorite word pairs (in part 2), as the
// user adds or removes them from the list by toggling the heart icon.
class RandomWordsState extends State<RandomWords> {

  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text('Funny Name Generator'),

        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],

      ),

      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(   // Add 20 lines from here...
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return new Scaffold(         // Add 6 lines from here...
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );

        },
      ),                           // ... to here.
    );
  }

  Widget _buildSuggestions() {

    return ListView.builder(

        padding: const EdgeInsets.all(16.0),

        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {

    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(

      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),

      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),

      onTap: () {
        setState((){
          if(alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }

    );
  }

}

class RandomWords extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RandomWordsState();

}