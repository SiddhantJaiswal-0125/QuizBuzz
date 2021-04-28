import 'package:flutter/material.dart';
import 'package:quizbuzz/Services/database.dart';
import 'package:quizbuzz/Views/CreateQuiz.dart';
import 'package:quizbuzz/Views/PlayQuiz.dart';
import 'package:quizbuzz/Views/signin.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream quizStream ;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList()
  {
    return Container(
      // margin: EdgeInsets.only(top: 5),
      // margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream:  quizStream,
        builder: (context,snapshot)
        {
          return snapshot.data == null ? Container():
              ListView.builder(itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                return QuizTile(
                  imageUrl: snapshot.data.documents[index].data()['quizimageurl'],
                  title:  snapshot.data.documents[index].data()['quiztitle'],
                  descrip:  snapshot.data.documents[index].data()['quizDesc'],
                  quizId: snapshot.data.documents[index].data()['quizId'],
                );
              });

        },
      ),

    );
  }
  @override
  void initState() {
    // TODO: implement initState

    databaseService.getQuizData().then((value){
      quizStream = value;
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appBar(context,'Quiz', 'Buzz',35),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20),
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),

            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()));

              // do something
            },
          )
        ],
        backgroundColor: Colors.black87 ,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizList(),
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
class QuizTile extends StatelessWidget {
  final String imageUrl , title, descrip , quizId;
  QuizTile({@required this.imageUrl, @required  this.descrip, @required this.title ,@required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayQuiz(quizId)
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        padding: EdgeInsets.only(top: 5,bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl, width: MediaQuery.of(context).size.width - 48, fit: BoxFit.cover)),
            Container(
              // color: Colors.blue,

              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black26,
                ),

                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [Text(title, style: TextStyle(color: Colors.white , fontSize: 24, fontWeight: FontWeight.w500),),
                   SizedBox(height: 6,),
                    Text(descrip, style: TextStyle(color: Colors.white , fontSize: 15, fontWeight: FontWeight.w400),)],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
