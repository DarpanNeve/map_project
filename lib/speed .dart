import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:location/location.dart';
import 'package:map_project/home.dart';
import 'package:map_project/speed_widget.dart';
import 'package:permission_handler/permission_handler.dart';

import 'location_data.dart';
Location location = Location();
class Speed extends StatefulWidget {
  const Speed({super.key});

  @override
  State<Speed> createState() => _SpeedState();
}
class _SpeedState extends State<Speed> {
  int acceleration = 0;
  final dio=Dio();
  late LocationData locationData;
Timer? timer;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableLocation();
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );

    timer=Timer.periodic(const Duration(seconds: 5), (timer) {
      checkRoad();
    });
  }
  enableLocation()async {
    if (await Permission.location.isDenied) {
      await Permission.location.request();
      setState(() {
        locationPermission = true;
      });
    }
    locationData = await location.getLocation();
  }
  checkRoad() async{
   final res=await dio.get("https://roads.googleapis.com/v1/nearestRoads?points=${locationData.latitude}%2C${locationData.longitude}&key=${FlutterConfig.get('GOOGLE_MAP')}");
    print(res.data["snappedPoints"][0]["placeId"]);
    var placeId=res.data["snappedPoints"][0]["placeId"];
    for (int i=0;i<locationDataPoints.length;i++){
      if(locationDataPoints[i].placeId==placeId){
        print("you are on the classified road");
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: locationPermission
          ? const Center(
              child: Text("Please enable location permission"),
            )
          : speedWidget,
    );
  }
}
