import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'joke_page.dart';

class CategoryPage extends StatefulWidget{
  @override
    _CategoryState createState() => new _CategoryState();
}

class _CategoryState extends State<CategoryPage>{
  List<String> categoryList;

    @override 
  void initState() {
      super.initState();
      categoryList=new List();
      fetchCategories();
    }

  Future<List> fetchCategories() async {
  final response =
      await http.get('https://api.chucknorris.io/jokes/categories');
  if (response.statusCode == 200) {
        setState(() {
          categoryList=List.from(json.decode(response.body));
    });
    return categoryList;
  } else {
    throw Exception('Failed to load categories');
  }
}

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: Text("Category"),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: new GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0),
                itemCount: categoryList.length,
                itemBuilder: (context, i) => new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  onPressed:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute( builder: (context) => 
                      JokePage(category: categoryList[i])),
                    );
                  }, 
                  child: new Text(categoryList[i],
                        style: new TextStyle( fontWeight: FontWeight.bold,
                      color: Colors.white, fontSize: 20.0), 
                      ),
                      color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ],
      )
      );
    }
}