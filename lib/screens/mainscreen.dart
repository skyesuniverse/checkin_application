import 'dart:convert';
import 'dart:io';

import 'package:checkin_application/models/employee.dart';
import 'package:checkin_application/myconfig.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final Employee employee;

  const MainScreen({super.key, required this.employee});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late double screenHeight, screenWidth, cardwitdh;

  final TextEditingController _prstateEditingController =
      TextEditingController();
  final TextEditingController _prlocalEditingController =
      TextEditingController();

  late Position _currentPosition;

  String curaddress = "";
  String curstate = "";
  String prlat = "";
  String prlong = "";

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(),
      body: (Center(
        child: Column(
          children: [
            // Container(
            //   margin: EdgeInsets.all(4),
            //   width: screenWidth * 0.4,
            //   child: Image.asset(
            //     "assets/images/profile.png",
            //   ),
            // ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 48.0),
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  Text(
                    widget.employee.name.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.employee.email.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    widget.employee.phone.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    //"RM ${double.parse(catchList[index].catchPrice.toString()).toStringAsFixed(2)}",

                    "Department: ${widget.employee.dept.toString()}",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _prstateEditingController.text,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _prlocalEditingController.text,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount:
                    6, // Replace with the actual number of attendance entries
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Date ${index + 1}'),
                    subtitle: Text(
                        'Present'), // Replace with the actual attendance status
                  );
                },
              ),
            ),
            // Container(

            //   decoration: BoxDecoration(

            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.2),
            //         spreadRadius: 2,
            //         blurRadius: 5,
            //         offset: Offset(
            //             0, 2), // Offset to control the position of the shadow
            //       ),
            //     ],
            //   ),
            //   child: ElevatedButton(
            //     onPressed: onCheckIn,
            //     child: const Text(
            //       'Check In',
            //       style: TextStyle(
            //         fontSize: 16,
            //       ),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.only(
            //           top: 8, bottom: 8, left: 15, right: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadiusDirectional.circular(25.0),
            //         // side: BorderSide(color: Colors.black),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: checkInDialog,
                  child: const Text(
                    'Check In',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 15, right: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(25.0),
                      // side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(
                        0, 2), // Offset to control the position of the shadow
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  void checkInDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Check in?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                checkIn();
                //registerUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkIn() {
    String state = _prstateEditingController.text;
    String locality = _prlocalEditingController.text;

    http.post(
        Uri.parse("${MyConfig().SERVER}/checkin_app/php/insert_checkin.php"),
        body: {
          "employeeid": widget.employee.id.toString(),
          "latitude": prlat,
          "longitude": prlong,
          "state": state,
          "locality": locality,
        }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        print(jsondata);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Check In Success")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Check In Failed")));
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Check In Failed")));
        Navigator.pop(context);
      }
    });
  }

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    // Handle permanently denied location permission
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }
    // Get the current position
    _currentPosition = await Geolocator.getCurrentPosition();
    // Get the address based on the current position
    _getAddress(_currentPosition);
    //return await Geolocator.getCurrentPosition();
  }

  _getAddress(Position pos) async {
    // Retrieve the list of placemarks (address) from coordinates
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placemarks.isEmpty) {
      // If no placemark is found, set default values for address
      _prlocalEditingController.text = "Changlun";
      _prstateEditingController.text = "Kedah";
      prlat = "6.443455345";
      prlong = "100.05488449";
    } else {
      // Set the address values based on the retrieved placemark
      _prlocalEditingController.text = placemarks[0].locality.toString();
      _prstateEditingController.text =
          placemarks[0].administrativeArea.toString();
      prlat = _currentPosition.latitude.toString();
      prlong = _currentPosition.longitude.toString();
    }
    setState(() {});
  }
}