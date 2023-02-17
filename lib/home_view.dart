import 'package:repairbike_2/ajoutService.dart';
import 'ajoutService.dart';
import 'accueil_view.dart';
import 'deconnexion.dart';
import 'majService.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView>createState()=> _HomeViewState();
} 

class _HomeViewState extends State<HomeView>{
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
   
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
        title: const Text('RepairBike'),
        elevation: 5.0,
        actions: [
          IconButton(
            icon : Icon(Icons.pedal_bike),
            onPressed: (){
              Navigator.pushNamed(context, '/accueil');
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children : const <Widget>[
          ServiceSection(),
          ajoutService(),
          MajService(),
          Deconnexion(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex : _currentIndex,
        onTap: (index){ 
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.person_add),
            label: 'Ajouter un service',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.person),
            label: 'Mise à jour du service',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.person_off_outlined),
            label: 'Se deconnecter',
          ),
        ],
      ), 
    );
  }
}
  
  