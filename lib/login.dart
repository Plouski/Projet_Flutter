import 'package:flutter/material.dart';
import 'auth.dart';

class TODOLogin extends StatefulWidget{
  final onLogin;
  TODOLogin({@required this.onLogin});
  @override
  State<StatefulWidget> createState(){
    return LoginState();
  }
}

class LoginState extends State<TODOLogin>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final auth = Authentification();
  void doLogin() async{
    final user = await auth.login(emailController.text, passwordController.text);
    print(user);
    print(emailController.text);
    print( passwordController.text);
    if(user!=null){
      widget.onLogin(user);
      Navigator.pushReplacementNamed(context, '/view');
    }
    else{
      _showAuthFailedDialog();
    }
  }
  
  void _showAuthFailedDialog(){
    showDialog(
      context : context,
      builder:(BuildContext context){
        return AlertDialog(
          title: const Text('Impossible de se connecter'),
          content : const Text('Vérifiez vos informations d\'identification et réessayez'),
          actions: <Widget>[
            new TextButton(
              child: new Text('Fermer'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Container(
      child:Scaffold(
          body:SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:<Widget>[
                  Image.asset('images/logo.png', height: 100.0, width: 100.0),
                  Center(
                    child: Text('Connexion pour les réparateurs',
                    style: Theme.of(context).textTheme.headline6),
                  ),
                  const SizedBox(height: 25.0),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                        child: Icon(Icons.person),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      fillColor: Colors.white, filled: true,
                      labelText: 'E-mail'
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(top: 0), // add padding to adjust icon
                        child: Icon(Icons.visibility_off),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      fillColor: Colors.white, filled: true,
                      labelText: 'Mot de passe'
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 25.0),
                  TextButton(
                    child: const Text(
                      "Se connecter",
                      style: TextStyle(fontSize: 14)
                    ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: doLogin,
                ),
                const SizedBox(height: 20),
                TextButton(
                  child: const Text(
                    "Si vous n'avez pas de compte, inscrivez-vous !",
                    style: TextStyle(fontSize: 14)
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: (){
                    Navigator.pushNamed( 
                      context, '/inscription', 
                      arguments: <String , String>{
                        'title':"Créer votre compte",
                      },
                    );
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}