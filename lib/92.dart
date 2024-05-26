import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for TextInputFormatter
import 'package:projj/Login.dart';
import 'main.dart';
import 'Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projj/Calc.dart';
import 'package:projj/Home.dart';
import 'package:projj/Car.dart';
import 'package:projj/Nearest.dart';
import 'predict.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController fuelController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final double fuelPrice = 12.5;
  double cost = 0.0;
  double fuel = 0.0;
  bool isUpdatingCost = false;
  bool isUpdatingFuel = false;

  @override
  void initState() {
    super.initState();
    fuelController.addListener(_calculateCost);
    costController.addListener(_calculateFuel);
  }

  @override
  void dispose() {
    fuelController.dispose();
    costController.dispose();
    super.dispose();
  }

  void _calculateCost() {
    if (!isUpdatingFuel) {
      isUpdatingCost = true;
      if (fuelController.text.isNotEmpty) {
        double fuelValue = double.tryParse(fuelController.text) ?? 0;
        setState(() {
          cost = fuelValue * fuelPrice;
          costController.text = cost.toStringAsFixed(2);
        });
      }
      isUpdatingCost = false;
    }
  }

  void _calculateFuel() {
    if (!isUpdatingCost) {
      isUpdatingFuel = true;
      if (costController.text.isNotEmpty) {
        double costValue = double.tryParse(costController.text) ?? 0;
        setState(() {
          fuel = costValue / fuelPrice;
          fuelController.text = fuel.toStringAsFixed(2);
        });
      }
      isUpdatingFuel = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Calculate padding based on screen size
    final padding = screenWidth * 0.1;

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
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fuel',
              style: TextStyle(
                color: Colors.red,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: fuelController,
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
              'Cost',
              style: TextStyle(
                color: Colors.red,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: costController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
