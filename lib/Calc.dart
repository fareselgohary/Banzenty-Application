import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        title: Text(
          "Banzenty",
          style: TextStyle(
              color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
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
              onTap: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>calc()));
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
              onTap: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NearestGasStation()));
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
              onTap: ()  {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CarMaintenance()));

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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ObjectDetectionScreen()));
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
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Button size
                ),
                child: Text(
                  '95',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FirstPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Button size
                ),
                child: Text(
                  '92',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
