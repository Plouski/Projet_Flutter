import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//A new Widget to render new Task creation Screen
class ajoutService extends StatefulWidget {
  const ajoutService({Key? key}) : super(key: key);

  @override
  State<ajoutService> createState() => _ajoutServiceState();
}

class _ajoutServiceState extends State<ajoutService> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User courentService;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tarifController = TextEditingController();
  final TextEditingController rayonController = TextEditingController();
  final collection = FirebaseFirestore.instance.collection('services');
  final rep = FirebaseFirestore.instance.collection('users').where("email",isEqualTo : FirebaseAuth.instance.currentUser!.email );
  final _formKey = GlobalKey<FormState>();
  late final DocumentSnapshot documentSnapshot;

  void clearText() {
    nameController.clear();
    descriptionController.clear();
    tarifController.clear();
    rayonController.clear();
  }
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      setState(() {
        this.courentService = _auth.currentUser!;
      });

      String _idService(){
        if(courentService != null){
          return courentService.uid;
        }else{
         return "pas de service courant";
        }
      }

      String email = documentSnapshot['email'];
      String nom = documentSnapshot['nom'];
      String adresse = documentSnapshot['adresse'];
      String cp = documentSnapshot['CP'];
      String ville = documentSnapshot['ville'];
      
      collection.add({'idService' : _idService(),'titre':nameController.text,'description':descriptionController.text,'tarif':tarifController.text,'rayon':rayonController.text,'adresse':adresse,'nom':nom,'CP': cp, 'ville': ville, 'email':email});
      
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: rep.snapshots(),
        builder:(context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if (streamSnapshot.hasData) {
          DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[0];
            return SingleChildScrollView(
              child : Container(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                child: Form  (
                  key: _formKey,
                    child : Column(
                      children:<Widget>[ 
                        Image.asset('images/logo.png', height: 100.0, width: 100.0),
                        Center(
                          child: Text('Ajouter un service',
                          style: Theme.of(context).textTheme.headline6),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            fillColor: Colors.white, filled: true,
                            labelText: 'Titre de service',
                          ),
                          validator: (val) => val!.isEmpty ? 'Entrez un titre' : null,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            fillColor: Colors.white, filled: true,
                            labelText: 'Description',
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter> [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: tarifController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            fillColor: Colors.white, filled: true,
                            labelText: 'Tarif',
                          ),
                          validator: (val) => val!.isEmpty ? 'Entrez un tarif' : null,
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          controller: rayonController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            fillColor: Colors.white, filled: true,
                            labelText: "Rayon d'intervention",
                          ),
                          validator: (val) => val!.isEmpty ? 'Entrez un rayon' : null,
                        ),
                        const SizedBox(height: 20),
                        OutlineButton(
                          child: const Text('Créez'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)
                          ),
                          onPressed: () async{
                          if(_formKey.currentState!.validate()){  
                            _create(documentSnapshot);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vous avez créé un service !')
                              )
                            );
                            clearText();
                          }
                          }
                        ),
                      ],
                    )
                  )
                )
              );
            }
            else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        }
          ),
          /*floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey,
            child : Icon(Icons.done),
            onPressed:()async {
              if(_formKey.currentState!.validate()){   
                _create(documentSnapshot);
                Navigator.pushNamed( 
                  context, '/view', 
                );
              }
            },
          ),
          */
    );
  }
}