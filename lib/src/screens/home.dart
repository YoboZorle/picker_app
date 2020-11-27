import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/user/custom_appbar.dart';
import 'package:pickrr_app/src/user/map/map.dart';
import 'file:///C:/Users/HP/Desktop/Development/MobileDev/picker_app/lib/src/widgets/nav_drawer.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: NavDrawer(),
            ),
            body: GestureDetector(
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
                        Positioned(bottom: 0, right: 0, child: notifPanel())
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
                              "Glad to meet you",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Ubuntu",
                                color: AppColor.primaryText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin:
                                EdgeInsets.only(left: 20, bottom: 5, top: 3),
                            child: new Text(
                              "Want to make deliveries?",
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
                          ListTile(
                            leading: Icon(
                              Icons.location_on_rounded,
                              color: Colors.redAccent,
                            ),
                            title: TextField(
                              decoration: InputDecoration(
                                hintText: "Enter pickup location...",
                                hintStyle: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w400,
                                    height: 1.35),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor.primaryText),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 20),
                            dense: true,
                          ),
                          SizedBox(height: 10),
                          ListTile(
                            leading: Transform.rotate(
                              angle: 120,
                              child: Icon(
                                Icons.navigation_rounded,
                                color: Colors.greenAccent,
                              ),
                            ),
                            title: TextField(
                                decoration: InputDecoration(
                              hintText: "Input destination location...",
                              hintStyle: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                  height: 1.35),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor.primaryText),
                              ),
                            )),
                            contentPadding: EdgeInsets.only(left: 20),
                            dense: true,
                          ),
                          Hero(
                            tag: "btn",
                            flightShuttleBuilder: _flightShuttleBuilder,
                            child: GestureDetector(
                              child: Container(
                                  height: 45,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      bottom: 18, left: 25, right: 25, top: 25),
                                  decoration: BoxDecoration(
                                    color: AppColor.primaryText,
                                    boxShadow: [Shadows.secondaryShadow],
                                    borderRadius: Radii.kRoundpxRadius,
                                  ),
                                  child: Text('Request Rider',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500))),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserOrder()),
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                ],
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

  Widget notifPanel() => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapPage()),
          );
        },
        child: Hero(
          tag: "notif",
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              Expanded(child: SizedBox()),
              Column(
                children: [
                  Badge(
                    animationDuration: Duration(milliseconds: 700),
                    elevation: 0,
                    animationType: BadgeAnimationType.scale,
                    badgeContent: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text('9',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Ubuntu",
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                    ),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.5),
                        child: SvgPicture.asset('assets/svg/kargo_notif.svg',
                            height: 25, semanticsLabel: 'Acme Logo'),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              SizedBox(width: 15),
            ]),
          ),
        ),
      );

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
