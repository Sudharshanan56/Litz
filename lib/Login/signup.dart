import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:litz/Bottom%20Navigation/Navigation.dart';
import 'package:litz/Homepage/home.dart';
import 'package:litz/Login/signin.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    String name = "", password = "", email = "";
    final _formkey = GlobalKey<FormState>();
    
    registration() async {
  if (password != null &&
      usernameController.text.isNotEmpty &&
      emailController.text.isNotEmpty) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: password!.trim(),
      );

      // Get UID
      String uid = userCredential.user!.uid;

      // Create user document in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'points': 0,
        'createdAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Navigation()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password Provided is too Weak",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Email Already Exists",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }
}


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.deepOrange,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true, // Hide the input for passwords
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Sign up logic
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      name = usernameController.text;
                      email = emailController.text;
                      password = passwordController.text;
                    });
                  }
                  registration();
                },
                child: Text('Sign Up', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Signin()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text('Click here', style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
