import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:repairbike_2/ajoutService.dart';
import 'package:repairbike_2/home_view.dart';
import 'package:repairbike_2/inscription.dart';
import 'accueil_view.dart';
import 'auth.dart';
import 'login.dart';
import 'task.dart';
import 'inscription.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(TODOApp());
}

class TODOApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TODO();
  }
}

//creation la class todo statfulwidget
class TODO extends StatefulWidget {
  //chaque statefull widget doit override createSTate
  @override
  State<StatefulWidget> createState() {
    return TODOState();
  }
}

//le state pour le widget TODO
class TODOState extends State<TODO> {
//Creating a list of tasks with some dummy values
  final List<Task> tasks =[];
  final Authentification auth = new Authentification();
  User? user;

  //creation de la fonction qui modifie l'etat quand on va creer un new task
  void onTaskCreated(String name, description, rayon, tarif,adresse,cp,ville){
    //toute modification d'etat doit etre dans la methode setState
    setState(
        (){
          tasks.add(Task(name,description,rayon,tarif,adresse,cp,ville));
        }
    );
  }
  void onLogin(User user){
   setState(
       (){
         this.user=user;
       }
   );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepairBike',
      initialRoute: '/',
      routes: {
//secreen to view tasks
        '/':(context)=>TODOLogin(onLogin:onLogin),
        '/view': (context) => HomeView(),
        '/create':(context) => ajoutService(),
        '/accueil' : (context) => ServiceSection(),
        '/inscription': (context) => Inscription(),
      },
    );
  }
}
