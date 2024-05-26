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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ObjectDetectionScreen(),
    );
  }
}

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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        title: Text(
          "Banzenty",
          style: TextStyle(
              color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
            Row(
              children: [
                Image.asset("images/banzenty.png", width: 100, height: 100),
              ],
            ),
            ListTile(
              title: Text(
                "Calculate Fuel",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.calculate,
                size: 45,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => calc()));
              },
            ),
            ListTile(
              title: Text(
                "Nearest Gas Station",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.ev_station,
                size: 45,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NearestGasStation()));
              },
            ),
            ListTile(
              title: Text(
                "Maintenance",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.settings,
                size: 45,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CarMaintenance()));
              },
            ),
            ListTile(
              title: Text(
                "Car Brand",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.car_repair,
                size: 45,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ObjectDetectionScreen()));
              },
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.logout,
                size: 45,
                color: Colors.white,
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Login()));
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
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              )
            else
              const Text('Pick an image to identify'),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
