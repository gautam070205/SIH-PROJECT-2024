import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInsideGeofence = false;
  bool isInsideGeofence1 = false;

  double? latitude1;
  double? longitude1;
  double? latitude12;
  double? longitude12;
  double? latitude;
  double? longitude;
  double? distance1;
  double? distance2;

  StreamSubscription<Position>? positionStream;

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _checkPermissionAndStartGeofencing();
  }

  Future<void> _checkPermissionAndStartGeofencing() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Permission denied, handle it here (show a dialog or something)
        return;
      }
    }

    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      // Location services are not enabled, handle it here
      // You could show a dialog asking the user to enable location services
      return;
    }

    // Get the initial position and start geofence monitoring
    _getInitialPosition();
    _startGeofenceMonitoring();
  }

  Future<void> _getInitialPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    } catch (e) {
      // Handle error, e.g., show a message to the user
      print('Error getting location: $e');
    }
  }

  void _startGeofenceMonitoring() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter:
            100, // Only update location if the device moves more than 100 meters
      ),
    ).listen((Position position) {
      _checkGeofence(position);
      _checkGeofence1(position);
    });
  }

  void _checkGeofence(Position position) {
    // latitude1 = 30.360020;
    // longitude1 = 76.451767;
    latitude1 = 29.6769;
    // Example latitude for office
    longitude1 = 75.5713; // Example longitude for office
    distance1 = 200.0; // 200 meters

    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      latitude1!,
      longitude1!,
    );

    setState(() {
      isInsideGeofence = distance <= distance1!;
    });

    if (isInsideGeofence) {
      _handleCheckIn();
    } else {
      _handleCheckOut();
    }
  }

  void _checkGeofence1(Position position) {
    latitude12 = 30.3513101;
    longitude12 = 76.3635279;
    // latitude1 = 29.6769;
    // Example latitude for office
    // longitude1 = 75.5713; // Example longitude for office
    distance2 = 200.0; // 200 meters

    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      latitude12!,
      longitude12!,
    );

    setState(() {
      isInsideGeofence1 = distance <= distance2!;
    });

    if (isInsideGeofence) {
      _handleCheckIn();
    } else {
      _handleCheckOut();
    }
  }

  void _handleCheckIn() {
    // Logic to handle check-in
    print('Checked In');
  }

  void _handleCheckOut() {
    // Logic to handle check-out
    print('Checked Out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocation Check-In/Check-Out'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              isInsideGeofence ? 'Inside Geofence' : 'Outside Geofence',
              style: TextStyle(fontSize: 24),
            ),
          ),
          if (latitude != null && longitude != null)
            Text('Latitude: $latitude, Longitude: $longitude'),
          Text('office Latitude: $latitude1, office Longitude: $longitude1'),

          Text(isInsideGeofence.toString()),
          Text(
              'under a distnace of ${distance1.toString()}'), // Additional text for debugging
          // Additional text for debugging
          SizedBox(
            height: 100,
          ),
          Text(
            isInsideGeofence1 ? 'Inside Geofence' : 'Outside Geofence',
            style: TextStyle(fontSize: 24),
          ),

          if (latitude != null && longitude != null)
            Text('Latitude: $latitude, Longitude: $longitude'),
          Text('office Latitude: $latitude12, office Longitude: $longitude12'),

          Text(isInsideGeofence1.toString()),
          Text('under a distnace of ${distance2.toString()}'),
        ],
      ),
    );
  }
}
