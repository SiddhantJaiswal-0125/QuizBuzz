import 'package:flutter/material.dart';
import 'package:quizbuzz/Views/CreateQuiz.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SystemChrome.setSystemUIOverlayStyle(
  SystemUiOverlayStyle(statusBarColor: Colors.black87));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context,'Quiz', 'Buzz',35),
        backgroundColor: Colors.black87 ,
        elevation: 0.0,
        brightness: Brightness.light,

      ),
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context)=> CreateQuiz()
          ),
          );
        },
      ),

    );
  }
}
