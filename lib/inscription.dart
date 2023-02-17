import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  //Collection Utilisateur depuis firestore
  final collection = FirebaseFirestore.instance.collection('users');

  String prenom='';
  String nom = '';
  String email = '';
  String adresse = '';
  String cp = '';
  String ville = '';
  String motDePass = '';
  String confimMdP = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Scaffold(
        backgroundColor: Colors.transparent,
        body:SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('images/logo.png', height: 100.0, width: 100.0),
                Center(
                  child: Text('Inscription',
                  style: Theme.of(context).textTheme.headline6),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                      child: Icon(Icons.person),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    fillColor: Colors.white, filled: true,
                    labelText: 'Prénom',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez un prénom' : null,
                  onChanged: (val) => prenom = val,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                      child: Icon(Icons.person),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    fillColor: Colors.white, filled: true,
                    labelText: 'Nom',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez un nom' : null,
                  onChanged: (val) => nom = val,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                      child: Icon(Icons.alternate_email),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    fillColor: Colors.white, filled: true,
                    labelText: 'Email',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez un email' : null,
                  onChanged: (val) => email = val,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                      child: Icon(Icons.location_on_outlined)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    fillColor: Colors.white, filled: true,
                    labelText: 'Adresse',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez une adresse' : null,
                  onChanged: (val) => adresse = val,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                      child: Icon(Icons.location_on)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    fillColor: Colors.white, filled: true,
                    labelText: 'Code postal',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez un CP' : null,
                  onChanged: (val) => cp = val,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                      child: Icon(Icons.location_city)
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    labelText: 'Ville',
                  ),
                  validator: (val) => val!.isEmpty ? 'Entrez une ville' : null,
                  onChanged: (val) => ville = val,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                      child: Icon(Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    fillColor: Colors.white, filled: true,
                    labelText: 'Mot de passe',
                  ),
                  validator: (val) => val!.length < 6 ? 'Entrez un mot de passe avec 6 ou plus'
                  'des caracteres' : null,
                  onChanged: (val) => motDePass = val,
                  obscureText: true,
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                      child: Icon(Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    fillColor: Colors.white, filled: true,
                    labelText: 'Confirmez le mot de passe',
                  ),
                  onChanged: (val) => confimMdP = val,
                  validator: (val) => confimMdP != motDePass ? 'Mot de passe ne correspond pas' : null,
                  obscureText: true,
                ),
                const SizedBox(height: 25.0),
                OutlineButton(
                  onPressed: () async{
                    try{
                      if(_formKey.currentState!.validate()){
                        await _auth.createUserWithEmailAndPassword(
                          email: email, 
                          password: motDePass
                        );
                        await collection.add({
                        'prenom': prenom,
                        'nom' : nom,
                        'email' : email,
                        'adresse' : adresse,
                        'CP' : cp,
                        'ville' : ville,
                        'titre': '',
                        'tarif': '',
                        'rayon': '',
                        'description': '',
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Inscription réussie !"
                            ),
                          ),
                        );
                        await Navigator.pushNamed( 
                        context, '/view', 
                        );
                      }
                    } 
                    on FirebaseAuthException catch (e) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text(' Oups! Inscription pas réussie'),
                          content: Text('${e.message}'),
                          actions: [
                              TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text('Ok'),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text("S'inscrire"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)
                  ),
                ),
                const SizedBox(height: 20),
                OutlineButton(
                  child: const Text('Avez-vous déjà un compte ?'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)
                  ),
                  onPressed: (){
                    Navigator.pushNamed( 
                      context, '/', 
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}