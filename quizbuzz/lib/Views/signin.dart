import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart'; 
import 'package:quizbuzz/Services/auth.dart';
import 'package:quizbuzz/Views/signup.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
import 'home.dart';


class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _loading = false;
  final AuthServices _authService = AuthServices();
  String email,password;


  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

 final _formKey =  GlobalKey<FormState>();
 signInmethod()  async
 {
   if(_formKey.currentState.validate())
     {
       setState(() {
         _loading = true;
       });

       await _authService.signInEmailAndPassword(email, password).then((value) {
         if(value!=null) {
           setState(() {
             _loading = false;
           });
           // print(value.toString());
           Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (context) => Home(),
           ),
           );
         }
       }
       );


     }
 }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black87));
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
        child: _loading ? Container(
          child:
          Center(child: CircularProgressIndicator(),
          ),
        ):  SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 600,
                  child: Column(
                    children: [
                      Spacer(),
                      TextFormField(
                         validator: (val)
                        {
                         return  val.isEmpty? " Enter Correct Email": null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email"
                        ),
                        onChanged: (val){
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      // Spacer(),
                      TextFormField(
                        validator: (val)
                        {
                          return  val.isEmpty? " Enter Correct Password": null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(

                            hintText: "Password"
                        ),
                        onChanged: (val){
                          password = val;
                        },
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      GestureDetector(
                        onTap: ()
                        {

                          signInmethod();
                        },
                        child: Container(

                          width: MediaQuery.of(context).size.width - 48,
                          padding: EdgeInsets.symmetric(vertical:18),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          // height: 50,
                          child: Center(child: Text('Sign In' , style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                          ),
                          ),
                          // child: ,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(width: 15,),
                            Text("Don't Have an Account" , style: TextStyle(fontSize: 16),),
                            SizedBox(width: 20,),
                            GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                      SignUp(),
                                  ),
                                  );
                                },
                                child: Text("Sign Up", style: TextStyle(fontSize: 16, decoration: TextDecoration.underline),)),

                          ],
                        ),
                      ),

                      SizedBox(
                        height: 80,
                      )


                    ],
                  ),
                ),
              ),
            )
      ),
    );
  }
}