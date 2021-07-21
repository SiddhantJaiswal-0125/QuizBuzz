import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizbuzz/Models/QuestionModel.dart';
import 'package:quizbuzz/Services/database.dart';
import 'package:quizbuzz/Views/result.dart';
import 'package:quizbuzz/Widgets/Quiz_PlayQWidget.dart';
import 'package:quizbuzz/Widgets/widgets.dart';


bool done = true;
class PlayQuiz extends StatefulWidget {
  final String quizId ;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int correct = 0;
int incorrected = 0;
int notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService() ;
  QuerySnapshot questionSnapshot;

 QuestionModel getQuestionModelFromDataSnapshot(DocumentSnapshot questionSnapshot2)
 {
   QuestionModel questionModel = new QuestionModel();
   questionModel.question = questionSnapshot2.data()['question'];
   // questionModel.option1
   List<String> options = [
     questionSnapshot2.data()['option1'],
     questionSnapshot2.data()['option2'],
     questionSnapshot2.data()['option3'],
     questionSnapshot2.data()['option4'],
   ];
options.shuffle();
   questionModel.option1 = options[0];
   questionModel.option2 = options[1];
   questionModel.option3 = options[2];
   questionModel.option4 = options[3];
   questionModel.correctOption = questionSnapshot2.data()['option1'];
   questionModel.answered = done;
   return questionModel;



 }

  @override
  void initState() {
    // TODO: implement initState
    databaseService = new DatabaseService();
    databaseService.getQuizQuestion(widget.quizId).then((value){
      questionSnapshot = value;
      notAttempted = questionSnapshot.documents.length ;
      correct  = 0;
      total = questionSnapshot.documents.length;
      incorrected = 0;
      setState(() {

      });
    });

    print("$total this is total ${widget.quizId}");
    print("quiz id is${widget.quizId}");
    super.initState();
  }
  // bool showanswer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: appBar(context,'Quiz', 'Buzz',35),
        backgroundColor: Colors.black87 ,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [
            questionSnapshot ==null ?
                Container(
                  child: Center(child: CircularProgressIndicator()),
                ): SingleChildScrollView
              (
                  child: Container(
                    height: 600,
                    child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics:  ClampingScrollPhysics(),
              itemCount: questionSnapshot.documents.length,
            itemBuilder: (context,index)
            {
      // bool show = false;
              return QuizPlayTile(
                      getQuestionModelFromDataSnapshot(questionSnapshot.documents[index] ),
                    index
              );

            },),
                  ),
                )
          ],
        ),
      ),

      floatingActionButton: GestureDetector(
        onDoubleTap: (){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
              Results(correct: correct,

            incorrect: incorrected,
          total: total,)
          )
          );

        },
        child: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: (){

            // showanswer = true;
            done = false;

            setState(() {

            });


            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
            //     Results(correct: correct,
            //
            //   incorrect: incorrected,
            // total: total,)
            // )
            // );


          },
        ),
      ),

    );
  }
}
class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  // final bool showans;


  QuizPlayTile(this.questionModel, this.index);
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Q${widget.index+1}.  "+widget.questionModel.question,style:  TextStyle(fontSize: 20,color: Colors.black87),),
          SizedBox(height: 12,),

          GestureDetector(
            onTap: (){
              if(widget.questionModel.answered)
                {
                  if(widget.questionModel.option1==
                      widget.questionModel.correctOption)
                    {
                      optionSelected = widget.questionModel.option1;
                      widget.questionModel.answered = true;
                      correct++;
                      notAttempted--;
                      setState(() {});

                    }
                  else{
                    optionSelected =  widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    incorrected++;
                    notAttempted--;
                    setState(() {

                    });;


                  }
                }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              decription: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
              // show: widget.showans,
            ),
          ),
          SizedBox(height: 4,),

          GestureDetector(
            onTap: (){
              if(
              widget.questionModel.answered)
              {
                //CORRECT
                if(widget.questionModel.option2==
                    widget.questionModel.correctOption)
                {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  correct++;
                  notAttempted--;
                  setState(() {});

                }
                else{
                  optionSelected =  widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  incorrected++;
                  notAttempted--;
                  setState(() {

                  });;


                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              decription: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
              // show: widget.showans,
            ),
          ),
          SizedBox(height: 4,),


          GestureDetector(
            onTap: (){
              if(widget.questionModel.answered)
              {
                if(widget.questionModel.option3==
                    widget.questionModel.correctOption)
                {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  correct++;
                  notAttempted--;
                  setState(() {});

                }
                else{
                  optionSelected =  widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  incorrected++;
                  notAttempted--;
                  setState(() {

                  });;


                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              decription: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
              // show: widget.showans,
            ),
          )
          ,
          SizedBox(height: 4,),



          GestureDetector(
            onTap: (){
              if(widget.questionModel.answered)
              {
                if(widget.questionModel.option4==
                    widget.questionModel.correctOption)
                {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  correct++;
                  notAttempted--;
                  setState(() {});

                }
                else{
                  optionSelected =  widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  incorrected++;
                  notAttempted--;
                  setState(() {

                  });;


                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              decription: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
              // show: widget.showans,
            ),
          ),
          SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
