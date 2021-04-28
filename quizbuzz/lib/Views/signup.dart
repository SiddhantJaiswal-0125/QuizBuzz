
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:quizapp2/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:quizbuzz/Services/auth.dart';
import 'package:quizbuzz/Views/home.dart';
import 'package:quizbuzz/Views/signin.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
import 'package:quizbuzz/helper/Functions.dart';


class SignUp extends StatefulWidget {
  final Function toogleView;

  SignUp({this.toogleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthServices authService = new AuthServices();
  // AuthServices authServices = new AuthServices();

  // DatabaseService databaseService = new DatabaseService/();
  final _formKey = GlobalKey<FormState>();

  // text feild
  bool _loading = false;
  String email = '', password = '', name = "";

  getInfoAndSignUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      await authService
          .signUpWithEmailAndPassword(email, password)
          .then((value) {
        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        HelperFunctions.saveUserLoggedInDetails(isLoggedIn: true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }
  bool seepass = true;
  IconData eye = Icons.remove_red_eye;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title: Hero(
            tag: 'appbar',
            child: appBar( context, 'Quiz', 'Buzz',65)),
        backgroundColor: Colors.black87,
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: _loading
            ? Container(
          child: Center(child: CircularProgressIndicator()),
        )
            : SingleChildScrollView(
              child: Container(
                height: 600,
                child: Column(
          children: [
                Spacer(),
                Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) =>
                          val.isEmpty ? "Enter an Name" : null,
                          decoration: InputDecoration(hintText: "Name"),
                          onChanged: (val) {
                            name = val;
                          },
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(
                          validator: (val) => validateEmail(email)
                              ? null
                              : "Enter correct email",
                          decoration: InputDecoration(hintText: "Email"),
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        TextFormField(

                          obscureText: seepass,
                          validator: (val) => val.length < 6
                              ? "Password must be 6+ characters"
                              : null,
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

                              hintText: "Password"),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            getInfoAndSignUp();
                          },
                          child: tapButton(context, 'Sign Up',MediaQuery.of(context).size.width)
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have and account? ',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 17)),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),
                                )
                                );
                                // Navigator.pop(context);
                              },
                              child: Container(
                                child: Text('Sign In',
                                    style: TextStyle(
                                        color: Colors.green,
                                        decoration: TextDecoration.underline,
                                        fontSize: 17)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                )
          ],
        ),
              ),
            ),
      ),
    );
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}