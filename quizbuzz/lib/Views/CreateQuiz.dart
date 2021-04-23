import 'package:flutter/material.dart';
import 'package:quizbuzz/Services/database.dart';
import 'package:quizbuzz/Views/addquestion.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
import 'package:random_string/random_string.dart';
class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String imageLink, _quizTitle, _quizDescription, quizId;

  DatabaseService databaseService = new DatabaseService();
  bool _loading = false;
  createQuizOnline() async
  {
    setState(() {
      _loading = true;
    });
    if(_formKey.currentState.validate())
      {
        quizId = randomAlphaNumeric(16);
        Map <String, String> quizMap =
            {
             "quizId"  : quizId,
              "quizimageurl" : imageLink,
              "quiztitle" : _quizTitle,
              "quizDesc" : _quizDescription,
            };

         await databaseService.addQuizData(quizMap, quizId).then((value) {
            setState(() {
              _loading = false;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddQuestion(),
              ));
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
        brightness: Brightness.light,
      ),
      body: _loading?Container(child: Center(
        child: CircularProgressIndicator(),
      ),):Form(
        key : _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                validator: (val)
                {
                  return val.isEmpty? " Enter Image URL":null ;
                },
                decoration: InputDecoration(
                  hintText: "Quiz Image URL",
                ),
                onChanged: (val)
                {
                  imageLink = val;
                },
              ),
              SizedBox(
                height: 6,
              ),

              TextFormField(
                validator: (val)
                {
                  return val.isEmpty? "Enter Valid Quiz Title":null ;
                },
                decoration: InputDecoration(
                  hintText: "Quiz Title",
                ),
                onChanged: (val)
                {
                  _quizTitle = val;
                },
              ),
              SizedBox(
                height: 6,
              ),

              TextFormField(
                validator: (val)
                {
                  return val.isEmpty? " Enter Valid Description":null ;
                },
                decoration: InputDecoration(
                  hintText: "Quiz Description",
                ),
                onChanged: (val)
                {
                  _quizDescription = val;
                },
              ),
              Spacer(),
              GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: tapButton(context, 'Create Quiz')),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
