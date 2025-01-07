import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //check les forme de validation
  final keyForm = GlobalKey<FormState>();

  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passcontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //variable pour mdp
  bool _passVariable = false;

  // methode validator
  /*String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter your email";
    final emailpattern = r'^[^@]+@[^@]+\.[^@]+';
    final regExp = RegExp(emailpattern);
    if (!regExp.hasMatch(value)) return "Email inavlide";
    return null;
  }

  String? passValidator(String? value) {
    if (value == null || value.isEmpty) return "Please enter your password";
    if (value.length < 6)
      return "Taille de mot de passe doit depasser 6 caracteres";
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Home Page",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white, // Définir le fond blanc ici
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

                  const Text("Welcome Back",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: Colors.blueAccent)),
                  SizedBox(height: 20),

                  //email
                  TextFormField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                        labelText: "Email",
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
                        labelText: "Password",
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
                    onPressed: () async {
                      if (keyForm.currentState!.validate()) {
                        try {
                          // Authentification Firebase
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passcontroller.text,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login successful!')),
                          );
                          Navigator.pushNamed(context, "/home");
                        } catch (e) {
                          // En cas d'erreur
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Login failed: ${e.toString()}')),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: Text("Don't have an account ?",
                          style: TextStyle(fontSize: 16, color: Colors.black)))
                ],
              ),
            )));
  }
}
