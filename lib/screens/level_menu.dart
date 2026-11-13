import 'package:flutter/material.dart';
import 'package:itsproject/screens/puzzle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class levelMenu extends StatefulWidget {
   levelMenu({super.key});

  @override
  State<levelMenu> createState() => _levelMenuState();
}

class _levelMenuState extends State<levelMenu> {
   static const totalLevels =4;
   int unlockedLevel =1;


  @override
  void initState() {
     super.initState();
     _loadProgress();
  }
  Future<void>_loadProgress() async{
    final prefs =await SharedPreferences.getInstance();
    setState(() {
      unlockedLevel=prefs.getInt('unlocked_level')?? 1;
    });
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text("PUZZLE LEVELS") ,
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(24.0),
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            childAspectRatio: 1.6,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ) ,
          itemCount: totalLevels,
          itemBuilder: (context,index){
           final  level =index+1;
           final locked =level>unlockedLevel;
           return GestureDetector(
             onTap: locked
                 ? null
                 :(){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> puzzle(level : level),
               ),
               ).then((_)=> _loadProgress());
             },
             child:AnimatedContainer(duration: Duration(milliseconds: 400),
               decoration:BoxDecoration(
                 color: locked
                     ?Colors.grey.shade300
                     :Colors.indigo.shade100,
                 borderRadius: BorderRadius.circular(18),
                 border: Border.all(
                   color: locked
                       ?Colors.grey
                       :Colors.indigo,
                   width: 3,
                 ),
               ) ,
               child: Stack(children: [
                 Center(
                   child: Text("Level $level",
                   style:TextStyle(
                     fontWeight: FontWeight.bold,
                         fontSize: 26,
                     color: locked
                       ?Colors.grey
                         :Colors.indigo[800],
                   ) ,
                   ),
                 ),
                 if(locked)
                   Center(
                     child: Icon(Icons.lock_outline,size: 40,color: Colors.grey,),
                   ),
               ],
               ),
             ) ,
           );
          }
      ),
    );
  }
}
