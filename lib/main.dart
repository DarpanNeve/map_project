import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  Location location = Location();
  late LocationData locationData;
  LatLng _center = const LatLng(0, 0);

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          elevation: 2,
        ),
        body: _center.latitude == 0
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                cameraTargetBounds: CameraTargetBounds.unbounded,
                mapType: MapType.normal,
                compassEnabled: true,
                buildingsEnabled: true,
              ),
      ),
    );
  }
}
