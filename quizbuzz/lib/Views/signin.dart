import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:quizbuzz/Services/auth.dart';
import 'package:quizbuzz/Views/signup.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
import 'home.dart';


// import 'package:quizapp2/services/auth.dart';
// import 'package:quizapp2/widget/widget.dart';

class SignIn extends StatefulWidget {


  // SignIn({this.toogleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthServices _authService = AuthServices();

  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title: Hero(tag: 'appbar',child: appBar( context, 'Quiz', 'Buzz', 35 )),
        backgroundColor: Colors.black87,
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Spacer(),
            Container(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ',
                          style:
                          TextStyle(color: Colors.black87, fontSize: 17)),
                      GestureDetector
                        (
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUp()),
                          );
                        },
                        child: Container(
                          child: Text('Sign Up',
                              style: TextStyle(
                                  color: Colors.black87,
                                  decoration: TextDecoration.underline,
                                  fontSize: 17)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}