import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/user/custom_appbar.dart';
import 'package:pickrr_app/src/widgets/nav_drawer.dart';

import 'package:pickrr_app/src/user/user_order.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GoogleMapController mapController;
  TextEditingController destinationController = new TextEditingController();
  TextEditingController pickupController = new TextEditingController();
  List<Marker> markersList = [];
  final String key = "AIzaSyAPV3djPp_HceZIbgK4M4jRadHA-d08ECg";
  LatLng _center = LatLng(
      4.778559, 7.016669); //port harcourt coordinates -- default location
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyAPV3djPp_HceZIbgK4M4jRadHA-d08ECg");
  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: "AIzaSyAPV3djPp_HceZIbgK4M4jRadHA-d08ECg");
  final List<Polyline> polyline = [];
  List<LatLng> routeCoords = [];
  Completer<GoogleMapController> __controller = Completer();

  PlaceDetails departure;
  PlaceDetails arrival;

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
      __controller.complete(controller);
    });
  }

  Future<Null> displayPredictionDestination(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(
          p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      setState(() {
        departure = detail.result;
        destinationController.text = detail.result.name;
        Marker marker = Marker(
            markerId: MarkerId('arrivalMarker'),
            draggable: false,
            infoWindow: InfoWindow(
              title: "This is where you will arrive",
            ),
            onTap: () {
              //print('this is where you will arrive');
            },
            position: LatLng(lat, lng)
        );
        markersList.add(marker);
      });

      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(lat, lng),
          zoom: 16.0
      )));

      computePath();
    }
  }

  Future<Null> displayPredictionPickup(Prediction p) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(
          p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      setState(() {
        arrival = detail.result;
        pickupController.text = detail.result.name;
        Marker marker = Marker(
            markerId: MarkerId('pickupMarker'),
            draggable: false,
            infoWindow: InfoWindow(
              title: "This is where you start",
            ),
            onTap: () {
              //print('this is where you will arrive');
            },
            position: LatLng(lat, lng)
        );
        markersList.add(marker);
      });

      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(lat, lng),
          zoom: 16.0
      )));
    }
  }

  computePath()async{
    LatLng origin = new LatLng(departure.geometry.location.lat, departure.geometry.location.lng);
    LatLng end = new LatLng(arrival.geometry.location.lat, arrival.geometry.location.lng);
    routeCoords.addAll(await googleMapPolyline.getCoordinatesWithLocation(origin: origin, destination: end, mode: RouteMode.walking));

    setState(() {
      polyline.add(Polyline(
          polylineId: PolylineId('iter'),
          visible: true,
          points: routeCoords,
          width: 6,
          geodesic: true,
          color: Colors.red,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: NavDrawer(),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: [
                      Hero(
                        tag: 'map',
                        flightShuttleBuilder: _flightShuttleBuilder,
                        child:
                        GoogleMap(
                          onMapCreated: onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 16.0,
                          ),
                          markers: Set.from(markersList),
                          polylines: Set.from(polyline),
                          indoorViewEnabled: true,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: false,
                          trafficEnabled: false,
                          buildingsEnabled: false,
                        ),
                      ),
                      CustomerAppBar(),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        Shadows.primaryShadow,
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          height: 8,
                          width: 60,
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Hello George,",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Ubuntu",
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin:
                          EdgeInsets.only(left: 20, bottom: 5, top: 3),
                          child: new Text(
                            "A driver is ready for you.",
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                height: 1.35),
                          ),
                        ),
                        Container(
                            height: 50.0,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10, top: 13),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.fromBorderSide(
                                  Borders.global_search_border),
                              boxShadow: [
                                Shadows.global_shadow_search,
                              ],
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "Enter Pickup Location",
                                    hintStyle: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: "Ubuntu",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Ubuntu",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                    border: InputBorder.none,
                                    prefixIcon: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 5),
                                          child: SvgPicture.asset(
                                              'assets/svg/pin.svg',
                                              height: 19,
                                              color: AppColor.primaryText,
                                              semanticsLabel:
                                              'search icon'),
                                        ),
                                      ],
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 15.0, top: 15.0),
                                  ),
                                  controller: pickupController,
                                  onTap: () async {
                                    Prediction p = await PlacesAutocomplete.show(
                                        context: context,
                                        apiKey: key,
                                        mode: Mode.fullscreen,
                                        language: "en",
                                        components: [
                                          new Component(Component.country, "ng")
                                        ]);
                                    displayPredictionPickup(p);
                                  },
                                ),
                              ],
                            )),
                        Container(
                            height: 50.0,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20, top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.fromBorderSide(
                                  Borders.global_search_border),
                              boxShadow: [
                                Shadows.global_shadow_search,
                              ],
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "Enter Destination Location",
                                    hintStyle: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: "Ubuntu",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Ubuntu",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                    border: InputBorder.none,
                                    prefixIcon: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 5),
                                          child: SvgPicture.asset(
                                              'assets/svg/nav.svg',
                                              height: 19,
                                              color: AppColor.primaryText,
                                              semanticsLabel:
                                              'search icon'),
                                        ),
                                      ],
                                    ),
                                    contentPadding: EdgeInsets.only(
                                        left: 15.0, top: 15.0),
                                  ),
                                  controller: destinationController,
                                  onTap: () async {
                                    Prediction p = await PlacesAutocomplete.show(
                                        context: context,
                                        apiKey: key,
                                        mode: Mode.fullscreen,
                                        language: "en",
                                        components: [
                                          new Component(Component.country, "ng")
                                        ]);
                                    displayPredictionDestination(p);
                                  },
                                ),
                              ],
                            )),
                        InkWell(
                          child: Container(
                              height: 47,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 20, right: 20, bottom: 35),
                              decoration: BoxDecoration(
                                color: AppColor.primaryText,
                                borderRadius: Radii.k25pxAll,
                              ),
                              child: Text('Request rider',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400))),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserOrder()),
                            );
                          },
                          splashColor: Colors.grey[300],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));

  }

  Widget _flightShuttleBuilder(
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext,
      ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }
}
