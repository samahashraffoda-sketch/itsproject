import 'dart:math';

import 'package:flutter/material.dart';
import 'package:itsproject/main.dart';


void main() => runApp(Memory());

class Memory  extends StatelessWidget {
   Memory ({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner:false ,
      home: MemoryGame(),
    );
  }
}



class MemoryGame extends StatefulWidget {
   MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => MemoryGame_State();
}

class MemoryGame_State extends State<MemoryGame> {
  List<String> emojis =[
  '🍎', '🍌', '🍇', '🍉', '🍓', '🍒', '🍎', '🍌', '🍇', '🍉', '🍓', '🍒'
];
  List<bool> flipped=[];
  int? firstIndex;
  bool waiting = false;

  @override
  void initState(){
    super.initState();
    emojis.shuffle(Random());
    flipped = List.filled(emojis.length, false);
  }
  void onCardTap(int i)async{
    if(waiting || flipped[i] )return ;
    setState(() => flipped[i]= true);

    if(firstIndex == null){
      firstIndex =i;
    } else{
      if(emojis[i] !=emojis[firstIndex!]) {
        waiting = true;
        await Future.delayed(Duration(seconds: 1));
        setState(() {
          flipped [i] = false;
          flipped[firstIndex!] = false;
          firstIndex = null;
          waiting = false;
        });
      }else{firstIndex=null;}
      }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor :Colors.teal[50],
      appBar: AppBar(backgroundColor:Colors.teal ,
      title: Text("FIND THE SAME"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>StartPage()),
            );
          },
        ),
      ),

      body: Center(
        child: GridView.builder(
            padding: EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: emojis.length,
            itemBuilder: (context,i){
              return GestureDetector(
                onTap: ()=> onCardTap(i),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.black26,blurRadius:3)],
                  ),
                  child: Center(
                    child: Text(
                     flipped[i] ? emojis[i] :'❓',
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                ),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
        setState((){
          emojis.shuffle(Random());
          flipped = List.filled(emojis.length, false);
           firstIndex= null;
        });
      },
        backgroundColor: Colors.teal,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
