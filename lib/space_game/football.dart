import 'package:flutter/material.dart';
import 'package:itsproject/main.dart';

class football extends StatelessWidget {
 football  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image: AssetImage("assets/background_football.jpg"),
            fit: BoxFit.contain,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.arrow_back_outlined),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>StartPage()),
        );
        },
      ),
    );
  }
}
