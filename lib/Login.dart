import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home.dart';
import 'Signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController emailaddress = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Banzenty",
            style: TextStyle(
                color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 90, horizontal: 30),
          child: Center(
            child: Form(
              key: formstate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (formstate.currentState!.validate()) {
                          print("valid");
                        } else {
                          print("no");
                        }
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailaddress.text,
                            password: pass.text
                        );
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));

                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontFamily: 'RationalTextDEMO-SemiBold'),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 10,
                      backgroundColor: Colors.red,
                      fixedSize: Size(230, 60),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Email Address",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'RationalTextDEMO-SemiBold'),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: emailaddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "empty!";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "type your email",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'RationalTextDEMO-SemiBold'),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: pass,
                    validator: (value2) {
                      if (value2!.isEmpty) {
                        return "empty!";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "8 Characters",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                    ),
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: emailaddress.text);
                        },
                        child: Text(
                          "Forget Password",
                          style: TextStyle(fontSize: 17, color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "OR",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signup()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontFamily: 'RationalTextDEMO-SemiBold'),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 10,
                      backgroundColor: Colors.red,
                      fixedSize: Size(160, 60),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
