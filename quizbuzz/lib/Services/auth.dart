import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizbuzz/Models/user.dart';
import 'package:firebase_core/firebase_core.dart';
class AuthServices
{


  FirebaseAuth _auth = FirebaseAuth.instance;

  UID _userFromFirebaseUser(User user)
  {
    return user!=null? UID(user.uid):null;

  }
  Future signInEmailAndPassword (String email, String password) async
  {
    try
    {
      User user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      return _userFromFirebaseUser(user);

      // return user;
    }
    catch(e)
    {
      print(e.toString());
    }

  }
Future signUpWithEmailAndPassword(String email, String password) async
{
  try
  {
    User user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return _userFromFirebaseUser(user);
  }
  catch(e)
  {
    print(e.toString());
  }
}

Future signOut() async
{
  try{
    return await _auth.signOut();
  }
  catch(e)
  {
    print(e.toString());
    return null;
  }
}

}