import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceSection extends StatefulWidget {
  const ServiceSection({Key? key}) : super(key: key);
  @override
  State<ServiceSection> createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  final collection = FirebaseFirestore.instance.collection('services')/*.where('email', isNotEqualTo: FirebaseAuth.instance.currentUser!.email)*/;
  
  @override
  Widget build(BuildContext context) {
    return Container (
      child: Scaffold(
        body: StreamBuilder(  
          stream: collection.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
             return Text('Error: ${snapshot.error}');
            }
            switch(snapshot.connectionState){
              case ConnectionState.waiting: 
              return Text('Chargement...');
              default :
              return ListView(
                children:snapshot.data!.docs.map(
                  (DocumentSnapshot document){
                    return ServiceCard(document);
                  },
                ).toList(),
              );
            }
          },
        ),   
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final DocumentSnapshot Data;
  const ServiceCard(this.Data);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          //1ere ligne
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Data['titre'].toUpperCase() + ' ' + Data['nom'],
                ),
                Text(
                  Data['tarif'] + ' €',
                ),
              ],
            ),
          ),
          //2eme ligne
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(
                  Data['description']
                ),
              ],
            ),
          ),
          //3eme ligne
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Row(
                  children:[
                    const Icon(
                      Icons.place,
                      color: Colors.grey,
                      size: 14.0,
                    ),
                    Text(
                      Data['adresse']+' '+Data['CP'],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}