import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  //check les forme de validation
  final keyForm = GlobalKey<FormState>();

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController confirmpasscontroller = TextEditingController();

  //variable pour mdp
  bool _passVariable = false;

  //varaible pour authentification
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // methode validator
  /*String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter your email";
    final emailpattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(emailpattern);
    if (!regExp.hasMatch(value)) return "Email inavlide";
    return null;
  }

  String? passValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter your email";
    if (value.length < 6)
      return "Taille de mot de passe doit depasser 6 caracteres";
  }*/

  String? confirmpassValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter your email";
    if (value != passcontroller.text) return "Password does not match";
    return null;
  }

  //Methode d'authentification/inscription avec firebase
  Future SignUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passcontroller.text.trim());

      if (userCredential.user != null)
        Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      //mdp moins de 6caracteres
      if (e.code.contains("weak-password")) {
        Fluttertoast.showToast(
          msg:
              "Le mot de passe est trop faible.Doit contenir au moin 6 caracteres",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        //Format invalide de l'email
        if (e.code.contains("invalid-email")) {
          Fluttertoast.showToast(
            msg: "Votre email n'a pas un format valide",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          //Adresse deja utilisé
          if (e.code.contains("email-already-in-use")) {
            Fluttertoast.showToast(
              msg: "Cette adresse mail est deja utilisée",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
          print(e);
        }
      }
    }
  }

  //-----------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Register Page",
            style: TextStyle(color: Colors.blue, fontSize: 24),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: keyForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("images/img1.png", height: 100, width: 100),
                  SizedBox(height: 20),
                  Text("Create Your Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.blueAccent)),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                        labelText: "email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.blueAccent,
                        )),
                    keyboardType: TextInputType.emailAddress,
                    //validator: emailValidator,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passcontroller,
                    obscureText:
                        !_passVariable, //on veut que ca soit true par defaut
                    decoration: InputDecoration(
                        labelText: "password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blueAccent,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passVariable = !_passVariable;
                              });
                            },
                            icon: Icon(_passVariable
                                ? Icons.visibility
                                : Icons.visibility_off))),

                    keyboardType: TextInputType.emailAddress,
                    //validator: passValidator,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: confirmpasscontroller,
                    obscureText:
                        !_passVariable, //on veut que ca soit true par defaut
                    decoration: InputDecoration(
                        labelText: "Confirm password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blueAccent,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passVariable = !_passVariable;
                              });
                            },
                            icon: Icon(_passVariable
                                ? Icons.visibility
                                : Icons.visibility_off))),

                    keyboardType: TextInputType.emailAddress,
                    //validator: passValidator,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: SignUp, // Appel de la méthode SignUp
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      )),
                  SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text("Already have an account ?",
                          style: TextStyle(fontSize: 16, color: Colors.green)))
                ],
              ),
            )));
  }
}
