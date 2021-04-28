import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizbuzz/Views/home.dart';
import 'package:quizbuzz/Views/signin.dart';
import 'package:quizbuzz/helper/Functions.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp() );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    checkUserLoggedInStatus();


  }
  checkUserLoggedInStatus() async
  {
       await HelperFunctions.getUserLoggedInDetails().then((value) {
      setState( () {
        _isLoggedIn = value;
      }
      );

       });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_isLoggedIn??false )? Home():SignIn(),
      // home: SignIn(),
    );
  }
}




// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return