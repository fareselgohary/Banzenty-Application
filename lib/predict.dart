import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Signup.dart';
import 'Car.dart';
import 'Login.dart';
import 'main.dart';
import 'Calc.dart';
import 'Nearest.dart';
import 'Home.dart';

class ObjectDetectionScreen extends StatefulWidget {
  const ObjectDetectionScreen({super.key});

  @override
  _ObjectDetectionScreenState createState() => _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  List<dynamic>? _recognitions;
  String result = "";

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant2.tflite",
      labels: "assets/labels2.txt",
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = image;
          file = File(image.path);
        });
        await detectImage(file!);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> detectImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _recognitions = recognitions;
      if (_recognitions != null && _recognitions!.isNotEmpty) {
        // Find the recognition with the highest confidence
        var highestConfidenceRecognition = _recognitions!.reduce((curr, next) => curr['confidence'] > next['confidence'] ? curr : next);
        result = highestConfidenceRecognition['label'];
      } else {
        result = "No results found";
      }
    });
    print(_recognitions);
  }

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Calculate sizes based on screen size
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.1,
      vertical: screenHeight * 0.03,
    );
    final buttonTextSize = screenWidth * 0.05;
    final appBarTextSize = screenWidth * 0.08;
    final drawerTextSize = screenWidth * 0.05;
    final iconSize = screenWidth * 0.08;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: iconSize),
        title: Text(
          "Banzenty",
          style: TextStyle(
              color: Colors.white, fontSize: appBarTextSize, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        backgroundColor: Colors.red,
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/banzenty.png", width: 80, height: 80),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "Calculate Fuel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.calculate,
                size: screenWidth * 0.08,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => calc()),
                );
              },
            ),
            ListTile(
              title: Text(
                "Nearest Gas Station",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.ev_station,
                size: screenWidth * 0.08,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NearestGasStation()),
                );
              },
            ),
            ListTile(
              title: Text(
                "Maintenance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.settings,
                size: screenWidth * 0.08,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CarMaintenance()),
                );
              },
            ),
            ListTile(
              title: Text(
                "Car Brand",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.car_repair,
                size: screenWidth * 0.08,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ObjectDetectionScreen()),
                );
              },
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.logout,
                size: screenWidth * 0.08,
                color: Colors.white,
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: screenHeight * 0.4,
                width: screenWidth * 0.8,
                fit: BoxFit.cover,
              )
            else
              Text(
                'Pick an image to identify',
                style: TextStyle(fontSize: buttonTextSize),
              ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8AA29E),
                padding: buttonPadding,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Pick Image from Gallery',
                style: TextStyle(fontSize: buttonTextSize, color: Colors.white),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              result,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: buttonTextSize),
            ),
          ],
        ),
      ),
    );
  }
}
