import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signup(),
    );
  }
}

class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);

  GlobalKey<FormState> formstate2 = GlobalKey();
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
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 30),
          child: Center(
            child: Form(
              key: formstate2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        if (formstate2.currentState!.validate()) {
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailaddress.text,
                            password: pass.text,
                          );
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                        } else {
                          print("no");
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "Sign Up",
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
                    validator: (email) {
                      if (email!.isEmpty) {
                        return "empty!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Type your email",
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
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "empty!";
                      } else if (password.length < 8) {
                        return "Password must be at least 8 characters.";
                      }
                      return null;
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
