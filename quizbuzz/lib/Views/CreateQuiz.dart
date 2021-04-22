import 'package:flutter/material.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(BuildContext, 'Quiz', 'Buzz', 35),
        backgroundColor: Colors.black87 ,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
