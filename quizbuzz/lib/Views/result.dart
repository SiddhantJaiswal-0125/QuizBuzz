import 'package:flutter/material.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
import 'home.dart';
class Results extends StatefulWidget {
  final int correct, incorrect , total;
  Results({@required this.correct,@required this.incorrect, @required this .total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(

          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.correct} / ${widget.total}",style: TextStyle(
                fontSize: 25
              ),),
              SizedBox(height: 8,),
            Text("You answered ${widget.correct} answers  Correctly "
                "and ${widget.incorrect}  answers Incrrectly",
            textAlign: TextAlign.center,
            style:TextStyle(
              fontSize: 20,
              color: Colors.grey,

            )
            ),
              SizedBox(height: 20,),

              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:
                      (context)=>Home(),));
                },
                  child: tapButton(context, "Go To Home", MediaQuery.of(context).size.width - 40))


            ],
          )
        ),
      ),


    );
  }
}
