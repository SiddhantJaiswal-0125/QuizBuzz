// import 'dart:html';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizbuzz/Services/auth.dart';
import 'package:quizbuzz/Views/signup.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
import 'package:quizbuzz/helper/Functions.dart';
import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:sign_button/sign_button.dart';
import 'user.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool _loading = false;
  Future <FirebaseUser> _signIn() async
  {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication _gsa = await googleSignInAccount.authentication;

      AuthCredential authCredential = GoogleAuthProvider.getCredential(idToken: _gsa.idToken,
      accessToken:  _gsa.accessToken);
    // Credential credential = AuthServices().cre
    setState(() {
      _loading = true;
    });
    User user = (await _auth.signInWithCredential(authCredential)).user;
    if(user!=null)
      {
        // print("NOT NULL SIDDHANT ");
        setState(() {
          _loading = false;

        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home( 1,)));
      }
    // else print("NULL");

  }

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

       await _authService.signInEmailAndPassword(email, password).then((value)
       {
         if(value!=null) {
           setState(() {
             _loading = false;
           });
           HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);

           // print(value.toString());
           Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (context) => Home(1),
           ),
           );
         }
       }
       );


     }
 }
 bool seepass = true;
 IconData eye = Icons.remove_red_eye;



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
                        obscureText: seepass,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: ()
                              {
                                setState(() {

                                  if(eye == Icons.remove_red_eye) {
                                    seepass = false;
                                    eye = Icons.remove_red_eye_outlined;
                                  }
                                  else
                                    {
                                      seepass = true;
                                      eye = Icons.remove_red_eye;

                                    }
                                });
                              },
                              child: new Icon(eye)),

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
                        child: tapButton(context, 'Sign In',MediaQuery.of(context).size.width)
                      ),
                      SizedBox(height: 10,),
                      // Divider(
                      //     color:Colors.black,
                      //
                      //
                      //
                      //   ),


                      SizedBox(height: 10,),
                      // SignInButton(
                      //     buttonType: ButtonType.googleDark,
                      //     buttonSize: ButtonSize.large,
                      //
                      //     imagePosition: ImagePosition.left,
                      //     onPressed: _signIn,
                      // ),
                    SizedBox(height: 10,),



                      SizedBox(height: 10,),
                      // Center(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       // SizedBox(width: 15,),
                      //       Text("Don't Have an Account" , style: TextStyle(fontSize: 16),),
                      //       SizedBox(width: 20,),
                      //       GestureDetector(
                      //           onTap: (){
                      //             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      //                 SignUp(),
                      //             ),
                      //             );
                      //           },
                      //           child: Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.blue,decoration: TextDecoration.underline),)),
                      //
                      //     ],
                      //   ),
                      // ),

                      SizedBox(
                        height: 100,
                      )


                    ],
                  ),
                ),
              ),
            )
      ),

        bottomNavigationBar:   Container(
    decoration: BoxDecoration(
    color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black.withOpacity(.1),
        )
      ],
    ),
           child: SafeArea(
             child: Padding(
               padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                rippleColor: Colors.black87,
                hoverColor: Colors.blue,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.yellow,
                color: Colors.black,
                tabs: [
                GButton(
                icon: Icons.account_box,
                iconSize: 30,
                text: 'ADMIN ',
                onPressed: () {},
                ),
                GButton(
                icon: Icons.supervisor_account_outlined,
                text: 'USER',
                onPressed: () {
                // Navigator.pop(context);
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                builder: (context) => userlogin(),
                ))
                ;
                },
                ),

                ],
                selectedIndex: 0,
                // onTabChange: (index) {
                // setState(() {
                // _selectedIndex = index;
                // }
                // );

                ),
                ),
    ),
    ),



    );
  }
}

