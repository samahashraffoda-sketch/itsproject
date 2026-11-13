import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:itsproject/pages//main_page.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Image.asset(
              "assets/play_galaxy.jpg",
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              fit: BoxFit.fill,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=> main_page() )
              );
            },
            backgroundColor: Colors.red,
            child: Text("START"),
            ),
        );
  }
}