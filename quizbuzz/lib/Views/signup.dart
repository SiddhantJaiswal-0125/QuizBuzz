
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:quizapp2/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:quizbuzz/Services/auth.dart';
import 'package:quizbuzz/Views/home.dart';
import 'package:quizbuzz/Views/signin.dart';
import 'package:quizbuzz/Widgets/widgets.dart';

// import 'package:quizapp2/services/auth.dart';
// import 'package:quizapp2/services/database.dart';
// import 'package:quizapp2/views/home.dart';
// import 'package:quizapp2/widget/widget.dart';

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

        // databaseService.addData(userInfo);

        // Constants.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

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
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? "Password must be 6+ characters"
                              : null,
                          decoration: InputDecoration(hintText: "Password"),
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
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
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