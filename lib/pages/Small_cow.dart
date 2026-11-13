import 'package:flutter/material.dart';
class  SmallCow extends StatelessWidget {
  SmallCow ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cow Facts'),
    centerTitle: true ,
    backgroundColor: Colors.brown,
      ),
      body: ListView(
          padding:EdgeInsets.all(16),
        children:[
        Text(
        "1. Cows have best friends and get stressed when separated"
        "Studies show that cows form strong social bonds and have best friends. When separated, their heart rates increase,"
            " and they show signs of anxiety — just like humans.\n\n"
        "🕵‍♀ 2. Cows can recognize over 100 individual faces (cow and human!)"
         " Cows have excellent memory and facial recognition abilities. They can remember and distinguish between more than 100 different faces,"
            " both of other cows and people.\n\n"
      "🗣 3. Cows talk to each other using different moos"
         " Their moos aren’t random — cows use different tones, volumes, and frequencies to communicate emotions, warn each other,"
            " call their calves, or express hunger.\n\n"
      "🧭 4. Cows have an internal compass — they align their bodies with the Earth's magnetic field"
      "Satellite images have shown that cows tend to face either north or south while grazing or resting."
            " Scientists believe this behavior is linked to the Earth’s magnetic field.\n\n"
      "🎨 5. No two cow spots are ever the same"
      "Just like human fingerprints or snowflakes, the black-and-white patterns on Holstein cows are completely"
            " unique to each individual — no two cows share the exact same markings.\n\n"
      "🎧 6. Cows respond positively to music"
         " Soft, calming music — especially classical — can increase milk production and keep cows relaxed. Some farms play music "
            "for their cows during milking sessions for this reason.\n\n",
style:TextStyle(fontSize: 25) ,

      ),
      ],
      ),
    ) ;
  }
}
