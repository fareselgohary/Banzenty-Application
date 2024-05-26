import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projj/Login.dart';
import 'Signup.dart';
import 'package:projj/Home.dart';
import 'package:projj/Car.dart';
import 'package:projj/Calc.dart';
import 'predict.dart';

class NearestGasStation extends StatefulWidget {
  @override
  _NearestGasStationState createState() => _NearestGasStationState();
}

class _NearestGasStationState extends State<NearestGasStation> {
  Position? currentLocation;
  GoogleMapController? mapController;
  List<Marker> markers = [];

  Future<void> _getCurrentLocation() async {
    try {
      var status = await Permission.location.request();
      if (status.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        setState(() {
          currentLocation = position;
        });
        _findNearbyGasStations();
      } else {
        debugPrint("Location permission denied");
      }
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  Future<void> _findNearbyGasStations() async {
    if (currentLocation == null) return;
    final lat = currentLocation!.latitude;
    final lng = currentLocation!.longitude;
    final apiKey = 'AIzaSyArh7vuaaLIJlXf7kXKh-tTyXhpbIG92e0';
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=5000&type=gas_station&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      setState(() {
        markers = results.map((result) {
          final geometry = result['geometry']['location'];
          return Marker(
            markerId: MarkerId(result['place_id']),
            position: LatLng(geometry['lat'], geometry['lng']),
            infoWindow: InfoWindow(title: result['name']),
          );
        }).toList();
      });
    } else {
      debugPrint("Error fetching gas stations: ${response.body}");
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: iconSize),
        title: Text(
          'Nearest Gas Station',
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
        backgroundColor: Colors.red,
        centerTitle: true,
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
                    fontSize: drawerTextSize,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.calculate,
                size: iconSize,
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
                size: iconSize,
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
                size: iconSize,
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
                size: iconSize,
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
                size: iconSize,
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
      body: Stack(
        children: [
          currentLocation == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
              zoom: 15.0,
            ),
            markers: Set.from(markers),
            onMapCreated: (controller) => mapController = controller,
          ),
        ],
      ),
    );
  }
}
