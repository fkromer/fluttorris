import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

Future<Joke> getJoke(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://api.chucknorris.io/jokes/random'));

  return Joke.fromJson(jsonDecode(response.body));
}

class Joke {
  final String id;
  final String url;
  final String value;

  const Joke({
    required this.id,
    required this.url,
    required this.value,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'] as String,
      url: json['url'] as String,
      value: json['value'] as String,
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  Future<Joke>? _futureJoke;

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
            buildLogo(),
            SizedBox(height: 10),
            buildTooltippedButton(),
            SizedBox(height: 10),
            (_futureJoke == null) ? buildDancingChuck() : buildFutureBuilder(),
          ],
        ),
      ),
    );
  }

  Image buildLogo() {
    return Image.asset('assets/images/chucknorris_logo_coloured_small@2x.png');
  }

  Image buildDancingChuck() {
    return Image.asset('assets/images/chuck-norris-dancing.gif');
  }

  Tooltip buildTooltippedButton() {
    return Tooltip(
      message: 'Request a random joke from chucknorris.io',
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _futureJoke = getJoke(http.Client());
          });
        },
        child: const Text('Get random Joke'),
      )
    );
  }

  FutureBuilder<Joke> buildFutureBuilder() {
    return FutureBuilder<Joke>(
      future: _futureJoke,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.value);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

}
