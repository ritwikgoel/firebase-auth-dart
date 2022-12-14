// ignore_for_file: sort_child_properties_last

import 'dart:ui';
import 'package:app/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'loggedin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
  routes: {
    
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/signup': (context) => const SignUp(),
  },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    GoogleSignIn _googlesignin = GoogleSignIn(scopes: ['email']);
    GoogleSignInAccount? user = _googlesignin.currentUser;
    var emailcontroller = TextEditingController();
    var passcontroller = TextEditingController();
    Future signIn() async {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailcontroller.text.trim())) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passcontroller.text.trim());
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpg"), fit: BoxFit.cover),
        ),
        child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return LoggedIn();
              }
              return Padding(
                padding: const EdgeInsets.all(23.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 125,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Sign In",
                            style: TextStyle(
                                fontSize: 60,
                                color: Color.fromARGB(255, 113, 113, 113)))),
                    const SizedBox(
                      height: 15,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign in with your username or email",
                          style: TextStyle(
                              color: Color.fromARGB(255, 113, 113, 113)),
                        )),
                    const SizedBox(
                      height: 75,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Container(
                        child: Column(
                          children: [
                            TextField(
                              controller: emailcontroller,
                              cursorColor: Colors.white,
                              decoration:
                                  const InputDecoration(labelText: '  Email'),
                            ),
                            TextField(
                              obscureText: true,
                              controller: passcontroller,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                labelText: '  Password',
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signIn();
                      },
                      child: const Text("Sign In"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(240, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        backgroundColor: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Center(
                      child: Text(
                        "Social login can save your valuable time",
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(70,0,0,0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(primary: Colors.white),
                            icon: ImageIcon(
                              NetworkImage(
                                  'http://pngimg.com/uploads/google/google_PNG19635.png'),
                                  color: Colors.black,
                            ),
                            label: Text('Google',style: TextStyle(color: Colors.black),),
                            onPressed: () async {
                              await _googlesignin.signIn();
                              MaterialPageRoute(builder: (context) => LoggedIn());
                              setState(() {});
                            },
                          ),
                        ),Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(primary: Colors.blue),
                            icon: ImageIcon(
                              NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgHJGHhuCyODJwwwar7-VY64N_qX4oXYOAwqriD7c&s'),
                                  color: Colors.black,
                            ),
                            label: Text('Facebook',style: TextStyle(color: Colors.black),),
                            onPressed: () async {
                              await _googlesignin.signIn();
                              MaterialPageRoute(builder: (context) => LoggedIn());
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
