import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itsproject/space_game/END_GAME.dart';
void main(){
  runApp(Earth());
}
class Earth extends StatelessWidget {
   Earth({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
        home: RocketScreen(),
    );

  }
}
class RocketScreen extends StatefulWidget {
   RocketScreen({super.key});

  @override
  State<RocketScreen> createState() => _RocketScreenState();
}

class _RocketScreenState extends State<RocketScreen> {
   int score=0;
  double velocity= 0;
  double rocketY=0.5;
  double rocketX=0;

  List<Ball> balls=[];
  Random random= Random();

  @override

  void initState(){
    super .initState();

    Timer.periodic(Duration(microseconds: 50), (timer){
      setState(() {
        velocity +=0.02;
        rocketY += velocity;

        if(rocketY>1) rocketY =1;

        for(var ball in balls){
          ball.y +=0.05;
        }
   balls.removeWhere((b) => b.y>1.2);

        for(var ball in balls){
          if((ball.x - rocketX).abs() <0.2 &&
              (ball.y - rocketY).abs() <0.2){
            score ++;
              ball.y =2;
          }
        }
        if(random.nextDouble()<0.05){
          balls.add(Ball(random.nextDouble()*2 -1,-1));
        }
      });
    });
  }
   void flyUp(){
    setState(() {
      velocity = -0.3;
    });
   }

   void moveRight(){
    setState(() {
      rocketX +=0.3;
      if(rocketX >1) rocketX=1;
    });
   }

   void moveLeft(){
    setState(() {
      rocketX -=0.3;
      if(rocketX<-1)rocketX=-1;

    });
   }
   void backToMenu(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EndGame()));
   }
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          for(var ball in balls)
            Align(
              alignment: Alignment(ball.x, ball.y),
              child: Icon(Icons.circle, color: Colors.white, size: 30,),
            ),
          Align(
            alignment: Alignment(rocketX, rocketY),
            child: Icon(Icons.rocket_launch_outlined, color: Colors.tealAccent, size: 100,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
              child: Text("Score: $score",
                style: TextStyle(color: Colors.amber,fontSize: 24),
              ),
          ),
      
      //control 
          Align(
            alignment: Alignment(-0.7,0.9),
            child: ElevatedButton(onPressed: moveLeft, child: Text("<--")),
          ),

        Align(
          alignment: Alignment(0, 0.9),
          child: ElevatedButton(onPressed:flyUp , child: Text("Jump"),
        ),
        ),


          Align(
            alignment: Alignment(0.7, 0.9),
            child: ElevatedButton(onPressed: moveRight, child: Text("-->")),
          ),

          Align(
            alignment: Alignment(0.9, -0.9),
            child: ElevatedButton(onPressed: backToMenu, child: Text("BACK")),
          )
        ],
       ),
       );
        }
}

class Ball{
  double x;
  double y;
  Ball(this.x,this.y);
}
