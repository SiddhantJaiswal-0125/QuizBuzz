import 'package:flutter/material.dart';
import 'package:quizbuzz/Services/database.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
class AddQuestion extends StatefulWidget {
 final String quizId;

 // AddQuestion(this.quizId);
  const AddQuestion({Key key, this.quizId}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  bool  _isloading = false;
  String question, option1, option2, option3,option4;
  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async
  {


    if(_formKey.currentState.validate())
    {
      Map<String , String> questionMap = {
        "question" : question ,
      "option1" : option1,
      "option2" : option2,
      "option3" : option3,
      "option4" : option4,
      };
      setState(() {
        _isloading = true;
      });

     await databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
       setState(() {
         _isloading = false;
       });
     });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(BuildContext, 'Quiz', 'Buzz', 35),
        backgroundColor: Colors.black87 ,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.yellow),
        brightness: Brightness.light,
      ),
      body:
      _isloading? Center(
        child: CircularProgressIndicator(
          backgroundColor:  Colors.green,
        ),
      ):
      SingleChildScrollView(
        child: Form(
          key:  _formKey,
          child: Container(
            height: 600,
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Column(

              children: [
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? "Enter Correct Question Name" : null,
                  // validator: (val)
                  // {
                  //   return val.isEmpty? "Enter Correct Question Name":null ;
                  // },
                  decoration: InputDecoration(
                    hintText: "Question",
                  ),
                  onChanged: (val)
                  {
                    question = val;
                    // imageLink = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),

                TextFormField(
                  validator: (val)
                  {
                    return val.isEmpty? "Enter Valid Option":null ;
                  },
                  decoration: InputDecoration(
                    hintText: "Option1 (Correct Answer)",
                  ),
                  onChanged: (val)
                  {
                    option1 = val;
                    // _quizTitle = val;
                  },
                ),
                SizedBox(
                  height: 6,
                ),

                TextFormField(
                  validator: (val)
                  {
                    return val.isEmpty? "Enter Valid Option":null ;
                  },
                  decoration: InputDecoration(
                    hintText: "Option2",
                  ),
                  onChanged: (val)
                  {
                    option2 = val;

                  },
                ),
                SizedBox(
                  height: 6,
                ),

                TextFormField(
                  validator: (val)
                  {
                    return val.isEmpty? "Enter Valid Option":null ;
                  },
                  decoration: InputDecoration(
                    hintText: "Option3",
                  ),
                  onChanged: (val)
                  {
                    option3 = val;

                  },
                ),
                SizedBox(
                  height: 6,
                ),

                TextFormField(
                  validator: (val)
                  {
                    return val.isEmpty? "Enter Valid Option":null ;
                  },
                  decoration: InputDecoration(
                    hintText: "Option4",
                  ),
                  onChanged: (val)
                  {
                    option4 = val;

                  },
                ),
                Spacer(),
                Row(

                  children: [

                    GestureDetector(
                      onTap: (){

                        Navigator.pop(context);
                      },
                        child: tapButton(context, "Submit",MediaQuery.of(context).size.width/2 - 36)
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                        onTap: () {
                          //TODO
                          uploadQuestionData();

                        },
                        child: tapButton(context, "Add Question" ,MediaQuery.of(context).size.width/2 - 36)),

                  ],
                ),
              SizedBox(height: 10,)

              ],


            ),

          ),
        ),
      ),
    );
  }
}
