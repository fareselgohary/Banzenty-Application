import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projj/Login.dart';
import 'main.dart';
import 'Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projj/Calc.dart';
import 'package:projj/Home.dart';
import 'package:projj/Nearest.dart';
import 'predict.dart';

class CarMaintenance extends StatefulWidget {
  @override
  _CarMaintenanceState createState() => _CarMaintenanceState();
}

class _CarMaintenanceState extends State<CarMaintenance> {
  final TextEditingController kmController = TextEditingController();
  double kmDriven = 0.0;
  double kmRemaining = 0.0;
  bool isUpdatingKm = false;

  final double maintenanceInterval = 5000.0;

  @override
  void initState() {
    super.initState();
    kmController.addListener(_calculateKmRemaining);
  }

  @override
  void dispose() {
    kmController.dispose();
    super.dispose();
  }

  void _calculateKmRemaining() {
    if (!isUpdatingKm) {
      isUpdatingKm = true;
      if (kmController.text.isNotEmpty) {
        double kmValue = double.tryParse(kmController.text) ?? 0;
        setState(() {
          kmDriven = kmValue;
          kmRemaining = maintenanceInterval - (kmDriven % maintenanceInterval);
        });
      }
      isUpdatingKm = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Calculate sizes based on screen size
    final appBarTextSize = screenWidth * 0.05;
    final drawerTextSize = screenWidth * 0.05;
    final iconSize = screenWidth * 0.08;
    final inputTextSize = screenWidth * 0.045;
    final bodyPadding = screenWidth * 0.1;
    final spacing = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: iconSize),
        title: Text(
          "Banzenty",
          style: TextStyle(
              fontSize: appBarTextSize,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
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
      body: Container(
        padding: EdgeInsets.all(bodyPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kilometers Driven',
              style: TextStyle(
                color: Colors.red,
                fontSize: inputTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacing),
            TextField(
              controller: kmController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: spacing * 1.5),
            Text(
              'Kilometers Remaining until next maintenance',
              style: TextStyle(
                color: Colors.red,
                fontSize: inputTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacing),
            Text(
              kmRemaining.toStringAsFixed(0),
              style: TextStyle(
                fontSize: inputTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spacing),
          ],
        ),
      ),
    );
  }
}
