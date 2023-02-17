import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MajService extends StatefulWidget {
  const MajService({Key? key}) : super(key: key);
  @override
  _MajServiceState createState() => _MajServiceState();
}

class _MajServiceState extends State<MajService> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User courentService;
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tarifController = TextEditingController();
  final TextEditingController _rayonController = TextEditingController();
  final CollectionReference _services = FirebaseFirestore.instance.collection('services');
   
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    setState(() {
      this.courentService = _auth.currentUser!;
    });
    
    String _idService(){
      if(courentService != null){
        return courentService.uid;
      }
      else{
        return "pas de service courant";
      }
    }
   
    if (documentSnapshot != null) {
      action = 'update';
      print(documentSnapshot['titre']);
      _titreController.text = documentSnapshot['titre'];
      _descriptionController.text = documentSnapshot['description'];
      _tarifController.text = documentSnapshot['tarif'];
      _rayonController.text = documentSnapshot['rayon'];
    }
    
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titreController,
                decoration: const InputDecoration(
                  labelText: 'Titre de service'
                ),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description'
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter> [
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: _tarifController,
                decoration: const InputDecoration(
                  labelText: 'Tarif',
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter> [
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: _rayonController,
                decoration: const InputDecoration(
                  labelText: "Rayon d'intervention",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(action =='create' ? 'Créer' : 'Modifier'),
                onPressed: () async {
                  final String? titre = _titreController.text;
                  final String? description =_descriptionController.text;
                  final String? rayon =_rayonController.text;
                  final String? tarif =_tarifController.text;
                  
                  if (titre != null && description != null && rayon != null && tarif != null) {
                    if(action=='create'){
                      await _services.add({'idService' : _idService(),'email': FirebaseAuth.instance.currentUser!.email,'titre':_titreController.text,'description':_descriptionController.text,'tarif':_tarifController.text,'rayon':_rayonController.text});
                    }
                    if (action =='update'){
                      await _services.doc(documentSnapshot!.id).update({"titre": titre, "description": description,"rayon": rayon, "tarif": tarif });
                      // vide les text fields
                      _titreController.text = '';
                      _descriptionController.text = '';
                      _rayonController.text = '';
                      _tarifController.text = '';
                    }
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      }
    );
  }
  
  Future<void> _deleteService(String serviceId) async {
    await _services.doc(serviceId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Vous avez supprimé un service')
    ));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _services.where("email",isEqualTo : FirebaseAuth.instance.currentUser!.email ).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(documentSnapshot['titre']),
                  subtitle: Text(documentSnapshot['description'].toString()),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                          _createOrUpdate(documentSnapshot)
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed:() => showDialog<String>(
                            context: context, 
                            builder: (BuildContext context)=>AlertDialog(
                              title: const Text('Voulez-vous vraiment supprimer ce service ?'),
                              actions: [
                                TextButton(
                                  child: const Text('Supprimer'),
                                  onPressed:() async{
                                    _deleteService(documentSnapshot.id);
                                    Navigator.pop(context, 'Supprimer');
                                  }
                                ),
                                TextButton(
                                  child: const Text('Annuler'),
                                  onPressed: () => 
                                  Navigator.pop(context, 'Annuler'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );  
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
  );
}
}
