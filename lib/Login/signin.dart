import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:litz/Bottom%20Navigation/Navigation.dart';
import 'package:litz/Homepage/home.dart';
import 'package:litz/Login/signup.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    String email = "", password = "";
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final _formkey = GlobalKey<FormState>();
    userLogin() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Navigation()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "No User Found for that Email",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Wrong Password Provided by User",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Sign In',
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
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                      password = passwordController.text;
                    });
                  }
                  userLogin();
                },
                child: Text('Sign In', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account? ',
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
