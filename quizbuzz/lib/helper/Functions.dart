import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions
{
  static String USERLOGGEDINKEY = "userloggedinkey";
  static saveUserLoggedInDetails({@required bool isLoggedIn}) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setBool(USERLOGGEDINKEY, isLoggedIn);
  }

 static  Future<bool> getUserLoggedInDetails()  async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
 return prefs.getBool(USERLOGGEDINKEY);
  }
  }

  // const String url