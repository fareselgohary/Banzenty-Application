import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:projj/SIgnup.dart';
import 'package:projj/firebase_options.dart';
import 'Home.dart';
import 'package:projj/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
Future<UserCredential?> signInWithFacebook(BuildContext context) async {
  try {
    // Log in with Facebook and obtain a LoginResult
    final LoginResult result = await FacebookAuth.instance.login();

    // Check if login was successful
    if (result.status == LoginStatus.success) {
      // Get the access token from the LoginResult
      final AccessToken? accessToken = result.accessToken;

      if (accessToken != null) {
        // Use the access token to sign in with Firebase
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        return userCredential;
      } else {
        // Handle case where access token is null
        print('Facebook login failed: access token is null');
        return null;
      }
    } else {
      // Handle case where login status is not success (e.g., user cancelled login)
      print('Facebook login cancelled or failed: ${result.status}');
      return null;
    }
  } catch (e) {
    // Handle other exceptions
    print('Error signing in with Facebook: $e');
    return null;
  }
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: SimpleProj(),
    );
  }
}

class SimpleProj extends StatelessWidget {
  const SimpleProj({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  print("yes");
                },
                child: Container(
                  child: Image.asset(
                    "images/banzenty.png",
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 20),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
