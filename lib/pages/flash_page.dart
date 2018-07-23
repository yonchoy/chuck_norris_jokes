import 'package:flutter/material.dart';
import './category_page.dart';

class FlashPage extends StatelessWidget{ 

  @override
  Widget build(BuildContext context){
    return new Material(
    color: Colors.blueAccent,
    child: new InkWell(
      onTap: () =>Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) =>new CategoryPage())),
      child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Image.network("https://assets.chucknorris.host/img/avatar/chuck-norris.png"),
      new Text("Chuck Norris", style: new TextStyle(color: Colors.white, fontSize: 40.0,fontWeight: FontWeight.bold),),
       new Text("Jokes", style: new TextStyle(color: Colors.white, fontSize: 40.0,fontWeight: FontWeight.bold),)
      ],
    ),
    )
    );
  }



}