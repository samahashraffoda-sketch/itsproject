import 'package:flutter/material.dart';
import 'package:itsproject/pages/Small_cow.dart';
import 'package:itsproject/pages/Small_cat.dart';
import 'package:itsproject/pages/small_dog.dart';


class Funny_Animals  extends StatelessWidget {
   Funny_Animals ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Funny Animals'),
      centerTitle:true ,
      backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child:Column (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> SmallCat() ),
                );
              },
              child: Image.asset("assets/small_cat.jpg",
                width: 300,
                height: 300,
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> SmallDog() ),
                );
              },
              child: Image.asset("assets/small_dog.jpg",
              width:200,
                height: 200,
            ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>SmallCow() ),
                );
              },
              child: Image.asset("assets/small_cow.jpg",
                  width:200,
                  height: 200,
              )
            )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
