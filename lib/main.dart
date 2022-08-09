import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign in with your username or email",
                          style: TextStyle(
                              color: Color.fromARGB(255, 113, 113, 113)),
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: emailcontroller,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: passcontroller,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signIn();
                      },
                      child: const Text("Sign In"),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
