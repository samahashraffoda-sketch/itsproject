import 'package:flutter/material.dart';

 class SmallCat  extends StatelessWidget {
   SmallCat ({super.key});

   @override
   Widget build(BuildContext context) {
     return  Scaffold(
       appBar: AppBar(title: Text('Сat Facts'),
       centerTitle:true,
       backgroundColor: Colors.blueAccent,
     ),
       body:ListView(padding:EdgeInsets.all(16),
         children: [Text("🐱 Cats can’t taste sweetness — their taste buds don’t detect sugar.\n\n"

           "💤 Cats spend about 70% of their lives sleeping.\n\n"

          " 👂 A cat’s ear has 32 muscles, which allow them to rotate each ear independently.\n\n"

           "🐾 Cats walk like camels and giraffes — both right feet move first, then both left.\n\n"

          " 💓 A cat’s heart beats almost twice as fast as a human’s (around 140–220 bpm).\n\n"

         "🐟 Some cats are allergic to fish, even though it’s often thought to be their favorite food.\n\n"

        "🌙 Cats can see in near-total darkness thanks to a special layer behind their retinas.\n\n"

       "👃 Each cat’s nose print is unique, just like a human fingerprint.\n\n"

      "🐈‍⬛ Black cats are considered lucky in some cultures (like in Japan and the UK).\n\n"

    " 🧠 Cats have a better memory than dogs — especially for remembering events and places.\n\n",
             style:TextStyle(fontSize: 25),
         ),
         ],
       ) ,
     );
   }
 }
