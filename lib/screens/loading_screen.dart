import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/networking.dart';
import 'location_screen.dart';
import 'package:weather_app/utilities/constants.dart';

const apiKey = 'efe47d08ce74fae30db678e77cbdfc3f';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude = 0.0;
  double longitude = 0.0;

  dynamic weatherData;

  @override
  void initState() {
    super.initState();
  }

  void getLocationData() async {
    Location location = Location(latitude: latitude, longitude: longitude);
    await location.getCurrentPosition();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            "https://api.openweathermap.org/data/2.5/weather?lat=$location.latitude&lon=$location.longitude&appid=$apiKey&units=metric");

    var weatherData = await networkHelper.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LocationScreen(
                          locationWeather: weatherData,
                        ),),);
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
