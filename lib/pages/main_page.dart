import 'package:flutter/material.dart';
import 'package:itsproject/pages/Funny_Animals.dart';
import 'package:itsproject/space_game/Earth.dart';
import 'package:itsproject/space_game/football.dart';
import 'package:itsproject/space_game/memory.dart';
import 'package:itsproject/space_game/painting.dart';
import 'package:itsproject/screens/puzzle.dart';

class main_page extends StatelessWidget {
  main_page({super.key});

  @override
  Widget build(BuildContext context) {
double screenHeight = MediaQuery.of(context).size.height;

final List<String> myImages=[
  "assets/Funny_animals.jpg",
  "assets/Out_Space.jpg",
  "assets/football.png",
  "assets/puzzle.png",
  "assets/memory.jpg",
  "assets/painting.png",

];
    return Scaffold(appBar: AppBar(
      title: Text('LETS PLAY'),
      centerTitle:true ,
      backgroundColor: Colors.red,
    ),
    body:GridView.builder(
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
        mainAxisSpacing: 40,
        childAspectRatio: 1,
      ),
    itemCount: myImages.length,
      itemBuilder: (context,index){
        return InkWell(
            onTap:(){
              if(index ==0) {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Funny_Animals()),
                );
              } else if(index ==1){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> Earth()));
                }else if(index ==2){
                Navigator.push(context, MaterialPageRoute(builder:(context)=> football()));
              }else if(index==3){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>puzzle(level:1)));
              }else if(index==4) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Memory()));
              } else if(index==5){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>painting ()));
              }
            },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:SizedBox(
            height: screenHeight  * 0.5,

          child: Image.asset(myImages[index],
            fit: BoxFit.cover,
          ),
          ),
        ),
        );
      },
    ),
    );
  }
}