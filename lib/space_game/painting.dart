import 'package:flutter/material.dart';

class painting extends StatelessWidget {
   painting({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("PAINT THE PICTURE"),
        centerTitle: true,
        backgroundColor: Colors.yellowAccent,
      ),
      backgroundColor: Colors.orangeAccent,
    );
  }
}
