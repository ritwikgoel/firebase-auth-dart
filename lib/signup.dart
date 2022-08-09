import 'package:app/loggedin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
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
                        child: Text("Sign Up",
                            style: TextStyle(
                                fontSize: 60,
                                color: Color.fromARGB(255, 113, 113, 113)))),
                    const SizedBox(
                      height: 15,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign up with your username or email",
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
                             
                              cursorColor: Colors.white,
                              decoration:
                                  const InputDecoration(labelText: '  Email'),
                            ),
                            TextField(
                              obscureText: true,
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
                        //signIn();
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
