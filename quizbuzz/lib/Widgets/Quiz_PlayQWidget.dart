import 'package:flutter/material.dart';
class OptionTile extends StatefulWidget {
  final String option, decription,correctAnswer , optionSelected;
  final bool show ;

  OptionTile({
    @required this.option,@required  this.decription,
  @required  this.correctAnswer,@required this.optionSelected, this .show});
  
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    Color co ;
    if(widget.show)
      {
     co =   widget.decription == widget.optionSelected?
        ( widget.optionSelected == widget.correctAnswer   ?
        Colors.green.withOpacity(0.8) : Colors.red.withOpacity(0.9)
        )  : Colors.grey;
      }
    else{
      co = widget.decription == widget.optionSelected? Colors.blue: Colors.grey;

    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [ 
          Container(
            width: 30,
            height: 30,

            decoration: BoxDecoration(
              border:  Border.all(
               color: co,
                width: 1.4,
              ),
              borderRadius: BorderRadius.circular(30)
            ),

            alignment: Alignment.center,
            child: Text("${widget.option}",style: 
            TextStyle(fontSize: 20,color: co,
              
            ),
            ),
          ),
          SizedBox(width: 8,),
          Text(widget.decription, style: TextStyle(fontSize: 19, color:Colors.black54),),
        ],
      ),
    );
  }
}

//
// color: widget.decription == widget.optionSelected?
// ( widget.optionSelected == widget.correctAnswer   ?
// Colors.green.withOpacity(0.8) : Colors.red.withOpacity(0.9)
// )  : Colors.grey,


// widget.optionSelected==widget.decription?
// (widget.optionSelected==widget.correctAnswer ?
// Colors.green : Colors.red): Colors.black54,