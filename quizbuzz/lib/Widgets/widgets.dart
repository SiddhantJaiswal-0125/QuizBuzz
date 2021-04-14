import 'package:flutter/material.dart';
Widget appBar(BuildContext  , String start , String end)
{
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 25),
        children: <TextSpan>[
          
          TextSpan(text: start, style: TextStyle(fontWeight: FontWeight.w500 , color:  Colors.white)),

          TextSpan(text: end, style: TextStyle(fontWeight: FontWeight.bold , color:  Colors.green)),

          TextSpan(text: "🐝" , style: TextStyle(fontWeight: FontWeight.w900 , color:  Colors.green, fontSize: 35)),
        ],
      ),
    ),
  );


}