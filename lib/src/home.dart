import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController myMapController;
  final Set<Marker> _markers = new Set();
  static const LatLng _mainLocation = const LatLng(4.814340, 7.000848);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _mainLocation,
              zoom: 15.6,
            ),
            markers: this.myMarker(),
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              setState(() {
                myMapController = controller;
              });
            },
          ),
        ),
        Container(height: 200,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Text('Yobo Zorle'))
      ],
    )));
  }

  Set<Marker> myMarker() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_mainLocation.toString()),
        position: _mainLocation,
        infoWindow: InfoWindow(
          title: 'Historical City',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    return _markers;
  }
}
