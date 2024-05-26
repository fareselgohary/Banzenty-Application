import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter
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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: 40),
        title: Text(
          "Banzenty",
          style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
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
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kilometers Driven',
              style: TextStyle(
                color: Colors.red,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 30),
            Text(
              'Kilometers Remaining until next maintenance',
              style: TextStyle(
                color: Colors.red,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              kmRemaining.toStringAsFixed(0),
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
