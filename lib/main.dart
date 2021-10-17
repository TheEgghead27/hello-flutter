// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),  // app bar and body defined here now
    );
  }
}

// stateless = immutable; stateful = mutable
// stateful needs StatefulWidget (immutable), which makes State (mutable, persistent)
// stful to general boilerplate
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

// state of class is where logic and stuff goes
class _RandomWordsState extends State<RandomWords> {
  // underscore is privacy indicator, best practice

  final _suggestions = <WordPair>[]; // array of wordpairs
  final _biggerFont = const TextStyle(fontSize: 18.0); // wowie wow wow fnots
  final wordPair = WordPair.random();

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        // make list
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          // builder property that does the building, called once per pair
          if (i.isOdd)
            return const Divider(); /*2, make a divider thing before each row */

          final index =
              i ~/ 2; /*3, integer division for calculating the number of rows*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs()
                .take(10)); /*4, make more rows if we ran out*/
          }
          return _buildRow(_suggestions[index]); // return a word block
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // define title and table structure stuff in this widget
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
    // return Text(wordPair.asPascalCase);
    // return Container();  generic
  }
}
