import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projj/92.dart';
import 'package:projj/Login.dart';
import 'package:projj/Nearest.dart';
import 'main.dart';
import 'SIgnup.dart';
import 'package:projj/Nearest.dart';
import '95.dart';
import 'package:projj/Home.dart';
import 'predict.dart';
import 'package:projj/Car.dart';

class calc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Calculate sizes based on screen size
    final buttonWidth = screenWidth * 0.4;
    final buttonHeight = screenHeight * 0.1;
    final buttonFontSize = screenWidth * 0.025;
    final padding = screenWidth * 0.1;
    final iconSize = screenWidth * 0.1;
    final drawerIconSize = screenWidth * 0.07;
    final drawerTextSize = screenWidth * 0.037;
    final appBarTitleSize = screenWidth * 0.095;
    final drawerImageSize = screenWidth * 0.25;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: iconSize),
        title: Text(
          "Banzenty",
          style: TextStyle(
              color: Colors.white, fontSize: appBarTitleSize, fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),],
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        backgroundColor: Colors.red,
        child: ListView(
          children: [
            Row(
              children: [
                Image.asset("images/banzenty.png", width: drawerImageSize, height: drawerImageSize),
              ],
            ),

            ListTile(
              title: Text(
                "Calculate Fuel",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: drawerTextSize,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.calculate,
                size: drawerIconSize,
                color: Colors.white,
              ),
              onTap: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>calc()));
              },
            ),
            ListTile(
              title: Text(
                "Nearest Gas Station",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: drawerTextSize,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.ev_station,
                size: drawerIconSize,
                color: Colors.white,
              ),
              onTap: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NearestGasStation()));
              },
            ),
            ListTile(
              title: Text(
                "Maintenance",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: drawerTextSize,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.settings,
                size: drawerIconSize,
                color: Colors.white,
              ),
              onTap: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CarMaintenance()));

              },
            ),
            ListTile(
              title: Text(
                "Car Brand",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: drawerTextSize,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.car_repair,
                size: drawerIconSize,
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
                    fontSize: drawerTextSize,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.logout,
                size: drawerIconSize,
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
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(buttonWidth, buttonHeight),
                ),
                child: Text(
                  '95',
                  style: TextStyle(fontSize: buttonFontSize/0.5, color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FirstPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(buttonWidth, buttonHeight),
                ),
                child: Text(
                  '92',
                  style: TextStyle(fontSize: buttonFontSize/0.5, color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
