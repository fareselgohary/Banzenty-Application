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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Banzenty",
            style: TextStyle(
                color: Colors.white, fontSize: screenWidth * 0.1, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.12, horizontal: screenWidth * 0.1),
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
                          fontSize: screenWidth * 0.08,
                          color: Colors.white,
                          fontFamily: 'RationalTextDEMO-SemiBold'),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      shadowColor: Colors.black,
                      elevation: 10,
                      backgroundColor: Color(0xFF3D5467),
                      fixedSize: Size(screenWidth * 0.6, screenHeight * 0.1),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                      child: Text(
                        "Email Address",
                        style: TextStyle(
                          color: Colors.red,
                            fontSize: screenWidth * 0.04,
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
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02, horizontal: screenWidth * 0.03),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.red,
                            fontSize: screenWidth * 0.04,
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
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.2),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02, horizontal: screenWidth * 0.03),
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
