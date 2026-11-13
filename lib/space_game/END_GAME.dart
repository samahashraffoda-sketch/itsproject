import 'package:flutter/material.dart';
import 'package:itsproject/main.dart';

class EndGame extends StatelessWidget {
  EndGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.black, width:3),
             ),
          child: Text("END GAME",
          style: TextStyle(
            fontSize: 55,
            fontWeight: FontWeight.w400,
            color: Colors.lightGreen
          ),
          ),
      ),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(builder: (context)=> StartPage()),
            (route) => false,
            );
          },
              child: Text("back to menu",
              style: TextStyle(
                fontSize: 30
              ),
              ),
          )
      ],
        ),
      ),
    );
  }
}
