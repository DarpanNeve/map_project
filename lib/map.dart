import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
LatLng _center = const LatLng(0, 0);
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  Location location = Location();
  late LocationData locationData;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  getLocation() async {
    locationData = await location.getLocation();
    double speed = locationData.speed!;
    debugPrint('Speed: $speed');
    setState(
          () {
        _center = LatLng(locationData.latitude!, locationData.longitude!);
      },
    );
  }
@override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    getLocation();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps App'),
        elevation: 2,
      ),
      body: StreamBuilder(
        stream: location.onLocationChanged,
        builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
          if (snapshot.hasData) {
            double speed = snapshot.data!.speed!;
            debugPrint('Speed: $speed');
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId:const MarkerId('1'),
                  position: _center,
                  infoWindow: const InfoWindow(title: 'You are here'),
                ),
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
