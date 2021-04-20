import 'package:flutter/material.dart';
Widget appBar(BuildContext  , String start , String end, double size)
{
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 25),
        children: <TextSpan>[
          
          TextSpan(text: start, style: TextStyle(fontWeight: FontWeight.w500 , color:  Colors.green)),

          TextSpan(text: end, style: TextStyle(fontWeight: FontWeight.bold , color:  Colors.red)),

          TextSpan(text: "🐝" , style: TextStyle(fontWeight: FontWeight.w900 ,  fontSize: size)),
        ],
      ),
    ),
  );


}