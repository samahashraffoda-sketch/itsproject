import 'package:flutter/material.dart';
class SmallDog  extends StatelessWidget {
  SmallDog ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text('Dog Facts'),
    centerTitle: true,
    backgroundColor: Colors.cyanAccent,
),
  body: ListView(
      padding: EdgeInsets.all(16),
    children:[
      Text(

    "🧠 1. Dogs can smell separately through each nostril"
    "Each nostril works independently, allowing dogs to determine the exact direction of a smell."
   " It’s similar to how humans use both eyes to perceive depth.\n\n"
    "💤 2. Dogs dream like humans – and some even have nightmares!"
    "Dogs enter the REM (Rapid Eye Movement) sleep stage, just like humans, which is when dreams occur."
     " Some dogs twitch, bark, or run in their sleep, showing signs of dreaming — and sometimes nightmares.\n\n"
 " 🧬 3. A dog’s nose print is as unique as a human fingerprint"
 "The patterns of ridges and creases on a dog’s nose are unique to each"
  "individual dog and can be used for identification.\n\n"
     "🎶 4. Dogs have musical preferences"
     " Studies show that dogs tend to relax when listening to classical music or reggae, "
      " while heavy metal or fast electronic music"
       " can make them anxious.\n\n"
    "🕵 5. Some dogs can detect cancer or illness before symptoms appear"
 " Dogs can detect cancer, diabetes, or even seizures by smelling the chemical changes in a person’s body,"
  "sometimes before medical tests detect them.\n\n"

 " 🐾 6. Dogs can suffer from depression"
 " Just like humans, dogs can experience sadness or depression, especially after losing a loved "
  "one or experiencing major changes in their environment.\n\n"

 " 👃 7. Dogs can smell human emotions"
     " With their powerful sense of smell,"
     " dogs can detect hormones like adrenaline,which rise when a person is scared or angry."
     "This allows them to sense emotions even if the person shows no visible signs\n\n",
     style: TextStyle(fontSize: 25),
  ),
      ],
  ),
    );
  }
}
