import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttorris',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fluttorris'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/chucknorris_logo_coloured_small@2x.png'),
            SizedBox(height: 10),
            Tooltip(
              message: 'Request a random joke from chucknorris.io',
              child: ElevatedButton(
                style: style,
                onPressed: () {},
                child: const Text('Get Joke'),
              ),
            ),
            SizedBox(height: 10),
            Image.asset('assets/images/chuck-norris-dancing.gif'),
          ],
        ),
      ),
    );
  }
}
