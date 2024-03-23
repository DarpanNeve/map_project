import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Speed extends StatelessWidget {
  const Speed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Location.instance.onLocationChanged,
        builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
          if (snapshot.hasData) {
            int speedInKm = (snapshot.data!.speed! * 3.6).toInt();
            return Directionality(
                textDirection: TextDirection.ltr,
                child: Center(child: Text('Speed: $speedInKm km/h')));
          } else {
            return const Center(child: Text('Speed: 0'));
          }
        },
      ),
    );
  }
}
