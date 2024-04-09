import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:map_project/speed%20.dart';

Widget speedWidget = StreamBuilder(
  stream: location.onLocationChanged,
  builder: (BuildContext context,
      AsyncSnapshot<LocationData> snapshot) {

    if (snapshot.hasData) {
      int speedInKm = (snapshot.data!.speed! * 3.6).toInt();
      return Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Speed: $speedInKm km/h'),
                Text(
                    "Acceleration:${snapshot.data!.speedAccuracy!
                        .toInt()} m/s²"),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Center(child: Text('Speed: 0'));
    }
  },
);