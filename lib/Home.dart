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
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final buttonPadding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.08,
      vertical: screenHeight * 0.015,
    );
    final buttonTextSize = screenWidth * 0.045;

    final buttonColor = Color(0xFF8AA29E);

    Widget flatButton(String text, VoidCallback onPressed) {
      return Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: buttonTextSize,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        title: Text(
          "Banzenty",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.08,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 120, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                flatButton(
                  'Find Nearest\nGas Station',
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NearestGasStation()),
                    );
                  },
                ),
                SizedBox(height: 20),
                flatButton(
                  'Calculate Fuel\nPurchase',
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => calc()),
                    );
                  },
                ),
                SizedBox(height: 20),
                flatButton(
                  'Car\nMaintenance',
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CarMaintenance()),
                    );
                  },
                ),
                SizedBox(height: 20),
                flatButton(
                  'Car Brand',
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ObjectDetectionScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
