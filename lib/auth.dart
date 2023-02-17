import 'package:firebase_auth/firebase_auth.dart';

class Authentification{
  final _firebaseAuth = FirebaseAuth.instance;
  Future<User?> login(String email,String password)async{
    try{
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password
      );
      return result.user;
    }
    catch(e){
     return null;
    }
  }
}