import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'dart:math';

void main() => runApp(MyJokeApp());




class MyJokeApp extends StatefulWidget {
  @override
  _MyJokeAppState createState() => _MyJokeAppState();
}

class _MyJokeAppState extends State<MyJokeApp> {
     String output= 'Tap Me';
     String punchline = "Joke";
     Color backColor= Colors.blue;
     final selectColors = [ Colors.blue,  Colors.red, Colors.blueGrey, Colors.orange,  Colors.purple,  Colors.deepOrangeAccent];

    Future WaitOnCall() async
    {


      String  url = 'https://official-joke-api.appspot.com/jokes/random';
      final val = await http.get(url);
      if (val.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(val.body);
        var setup = jsonResponse['setup'];
        var punch = jsonResponse['punchline'];
        output=  setup;
        punchline = punch;


      } else {
        output=  "Oops an error occured";
        punchline = " ";
      }
    }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backColor,
        body:Center(
         child: GestureDetector(
            onTap: () {
              setState(() {
                var num = new Random();
                int val = num.nextInt(selectColors.length);
                backColor= selectColors[val];
                WaitOnCall();
              });
            },
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(output,
                  style: TextStyle( fontSize: 50,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),

                Text(punchline,
                  style: TextStyle( fontSize: 50,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            )

          ),
        ),



    )
    );
  }
}
