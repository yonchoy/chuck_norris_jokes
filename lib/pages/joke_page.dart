import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/joke.dart';


class JokePage extends StatelessWidget {
final String category;

  // In the constructor, require a Todo
  JokePage({Key key, @required this.category}) : super(key: key);

Future<Joke> fetchJoke( String categoty) async {
  final response =
      await http.get('https://api.chucknorris.io/jokes/random?category='+categoty);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Joke.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load a joke');
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuck Norris Jokes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chuck Norris Jokes'),
        ),
        body: Center(
          child: FutureBuilder<Joke>(
            future: fetchJoke(category),
            builder: (context, snapshot) {
              if (snapshot.hasData){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Image.network(snapshot.data.iconUrl,),
                    Text(snapshot.data.value, 
                    style: TextStyle(fontSize: 35.0, color: Colors.blue,
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic ,
                    fontFamily: "DejaVu")),
                    // new RaisedButton(
                    //     child: Text("Back", style: 
                    //     TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                    //     color: Colors.blueAccent,
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //   )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
