import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());


//Stateless widgets are immutable, meaning that their properties can’t change—all values are final.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final wordPair = WordPair.random();

    return MaterialApp(
      title: 'StartUp Name Generator',
      home: RandomWords(),
    );
  }
}

//Most of the app’s logic and state resides here—it maintains the state for the
// RandomWords widget. This class saves the generated word pairs, which grows
// infinitely as the user scrolls, and favorite word pairs (in part 2), as the
// user adds or removes them from the list by toggling the heart icon.
class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
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
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

}

class RandomWords extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RandomWordsState();

}