import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        debugShowCheckedModeBanner: false,                      // debug banner
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, surface: Colors.lightBlue[300], // Explicitly set surface color
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,            // Vertically center children
          children: [
            SizedBox(height: 10),                                 // spacing added
            BigCard(pair: pair),
            SizedBox(height: 10),                                 // spacing added
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next!'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);                            // ← the code requests the app's current theme with Theme.of(context)

    final style = theme.textTheme.labelSmall!.copyWith(
      color: theme.colorScheme.onSurface,                       // Use onSurface for text on surface
      fontWeight: FontWeight.w500,
    );

    return Card(
      color: theme.colorScheme.surface,                         // ← Then, the code defines the card's color to be the same as the theme's colorScheme
                                                                // property. The color scheme contains many colors, and primary is the most prominent,
                                                                // defining color of the app.
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
            pair.asPascalCase,                                  // Use PascalCase for consistency
            style: style,
            semanticsLabel: "${pair.first} ${pair.second}",     // fixed typo in interpolation
        ),
      ),
    );
  }
}