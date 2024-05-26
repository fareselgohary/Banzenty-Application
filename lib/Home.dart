import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Signup.dart';
import 'Car.dart';
import 'Login.dart';
import 'package:projj/predict.dart';
import 'main.dart';
import 'Calc.dart';
import 'Nearest.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Calculate sizes based on screen size
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.1,
      vertical: screenHeight * 0.02,
    );
    final buttonTextSize = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        title: Text(
          "Banzenty",
          style: TextStyle(
              color: Colors.white, fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold),
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
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.calculate,
                size: screenWidth * 0.1,
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
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.ev_station,
                size: screenWidth * 0.1,
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
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.settings,
                size: screenWidth * 0.1,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CarMaintenance()));
              },
            ),
            ListTile(
              title: Text(
                "Car Brand",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.car_repair,
                size: screenWidth * 0.1,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ObjectDetectionScreen()));
              },
            ),
            ListTile(
              title: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.logout,
                size: screenWidth * 0.1,
                color: Colors.white,
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 120, horizontal: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NearestGasStation()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                  padding: buttonPadding, // Button size
                ),
                child: Text(
                  'Find Nearest\n Gas Station',
                  style: TextStyle(fontSize: buttonTextSize, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => calc()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                  padding: buttonPadding, // Button size
                ),
                child: Text(
                  'Calculate Fuel \n Purchase',
                  style: TextStyle(fontSize: buttonTextSize, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CarMaintenance()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                  padding: buttonPadding, // Button size
                ),
                child: Text(
                  'Car \n Maintenance',
                  style: TextStyle(fontSize: buttonTextSize, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ObjectDetectionScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                  padding: buttonPadding, // Button size
                ),
                child: Text(
                  'Car Brand',
                  style: TextStyle(fontSize: buttonTextSize, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
