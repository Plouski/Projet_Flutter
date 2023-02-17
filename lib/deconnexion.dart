import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Deconnexion extends StatefulWidget {
  const Deconnexion({Key? key}) : super(key: key);

  @override
   State<Deconnexion>createState() => _Deconnexion();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
_signOut() async {
  await _firebaseAuth.signOut();
}

class _Deconnexion extends State<Deconnexion> {
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
        children: <Widget>[
          Image.asset('images/logo.png', height: 100.0, width: 100.0),
              Center(
                child: Text('',
                style: Theme.of(context).textTheme.headline6),
              ),
              TextButton(
                child: Text(
                  "Deconnexion".toUpperCase(),
                  style: TextStyle(fontSize: 14)
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black)
                    )
                  )
                ),
                onPressed: ()async {
                  await _signOut();
                  if (_firebaseAuth.currentUser == null) {
                    Navigator.pushNamed(
                      context, '/', 
                    );
                  }
                }
              ),
              SizedBox(height: 10.0),
              Image.asset('images/smile.png', height: 200, width: 500),
        ],
      ),
    );
  }
}