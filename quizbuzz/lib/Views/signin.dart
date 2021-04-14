import 'package:flutter/material.dart';
import 'package:quizbuzz/Widgets/widgets.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar( context, 'Quiz', 'Buzz'),
        backgroundColor: Colors.black87,
        elevation: 0.0,
        brightness: Brightness.dark,
      ),
      body: Form(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child:  Column(

            children: <Widget>[
              Spacer(),
              TextFormField(
                validator: (val){
                  return  val.isEmpty ?   "Enter Correct Email Id ": null ;
                },
                decoration: InputDecoration(hintText: "Enter Your Email"
                ),
                onChanged: (val){
                  email = val;
                  },),
              SizedBox(height: 8,),
              TextFormField(
                validator: (val){
                  return  val.isEmpty ?   "Enter Correct Password ": null ;
                },
                decoration: InputDecoration(hintText: "Enter Your Password"
                ),
                onChanged: (val){
                  password = val;
                },),
              SizedBox(height: 25,),
              Container(

                padding: EdgeInsets.symmetric(vertical: 12),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(40)
                ),
                alignment: Alignment.center,

                width: MediaQuery.of(context).size.width - 48,
                child: Text("Sign In" ,style:  TextStyle(color: Colors.white , fontSize: 18),),
              ),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't Have an Account ?  " , style:  TextStyle(fontSize: 16),),

                  Text("SignUp " , style:  TextStyle(fontSize: 16, decoration: TextDecoration.underline),)
                ],
              ),
              SizedBox(height: 89,),

            ],
          ),
        ),
      ),

    );
  }
}
