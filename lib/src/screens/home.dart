import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  GoogleMapController myMapController;
  final Set<Marker> _markers = new Set();
  static const LatLng _mainLocation = const LatLng(4.814340, 7.000848);

  @override
  void initState() {
    print('Loading page');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: _mainLocation,
                                zoom: 15.6,
                              ),
                              markers: this.myMarker(),
                              mapType: MapType.normal,
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                              onMapCreated: (controller) {
                                setState(() {
                                  myMapController = controller;
                                });
                              },
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
                                "Hello Yobo,",
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
                                      onTap: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => UserOrder()),
                                        );
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
                                      onTap: () async {},
                                    ),
                                  ],
                                )),
                            GestureDetector(
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
                              },
                            ),
                          ],
                        )),
                  ],
                ),
              ),
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
