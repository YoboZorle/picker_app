import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pickrr_app/src/auth/otp_verification.dart';
import 'package:pickrr_app/src/user/custom_appbar.dart';
import 'package:pickrr_app/src/user/user_drawer.dart';
import 'package:pickrr_app/src/values/values.dart';

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
              child: UserDrawer(),
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
                        GoogleMap(
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
                          ListTile(
                            leading: Icon(
                              Icons.location_on_rounded,
                              color: Colors.grey[500],
                            ),
                            title: TextField(
                                decoration: InputDecoration(
                                    hintText: "Input pickup location...")),
                            contentPadding: EdgeInsets.only(left: 20),
                            dense: true,
                          ),
                          SizedBox(height: 10),
                          ListTile(
                            leading: Transform.rotate(
                              angle: 120,
                              child: Icon(
                                Icons.navigation_rounded,
                                color: Colors.grey[500],
                              ),
                            ),
                            title: TextField(
                                decoration: InputDecoration(
                                    hintText: "Input destination location...")),
                            contentPadding: EdgeInsets.only(left: 20),
                            dense: true,
                          ),
                          Hero(
                            tag: "btn",
                            flightShuttleBuilder: _flightShuttleBuilder,
                            child: GestureDetector(
                              child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      bottom: 18, left: 25, right: 25, top: 25),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryText,
                                    boxShadow: [Shadows.secondaryShadow],
                                    borderRadius: Radii.kRoundpxRadius,
                                  ),
                                  child: Text('FIND RIDER',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Ubuntu',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500))),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OTPVerification(authId: null)),
                                );
                              },
                            ),
                          ),
                        ],
                      )),

                  // Container(
                  //   height: MediaQuery.of(context).size.height / 2.1,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       Shadows.primaryShadow,
                  //     ],
                  //   ),
                  //   child: Expanded(
                  //     child: Column(
                  //       children: [
                  //         Container(
                  //           height: 8,
                  //           width: 60,
                  //           margin: EdgeInsets.only(top: 15, bottom: 15),
                  //           decoration: BoxDecoration(
                  //               color: Colors.grey[300],
                  //               borderRadius: BorderRadius.circular(16)),
                  //         ),
                  //         Container(
                  //           alignment: Alignment.centerLeft,
                  //           margin: EdgeInsets.only(left: 20),
                  //           child: Text(
                  //             "Glad to meet you!",
                  //             textAlign: TextAlign.left,
                  //             style: TextStyle(
                  //               fontSize: 14.5,
                  //               fontFamily: "Ubuntu",
                  //               color: AppColors.primaryText,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           alignment: Alignment.centerLeft,
                  //           margin: EdgeInsets.only(left: 20),
                  //           child: new Text(
                  //             "Want to make deliveries?",
                  //             maxLines: 1,
                  //             textAlign: TextAlign.left,
                  //             style: TextStyle(
                  //                 fontSize: 20.0,
                  //                 fontFamily: "Ubuntu",
                  //                 color: Colors.black,
                  //                 fontWeight: FontWeight.w700,
                  //                 height: 1.35),
                  //           ),
                  //         ),
                  //         Container(
                  //             height: 0.8,
                  //             margin: EdgeInsets.only(top: 10, bottom: 15),
                  //             width: MediaQuery.of(context).size.width,
                  //             color: Colors.grey[300]),
                  //         ListTile(
                  //           leading: Icon(
                  //             Icons.location_on_rounded,
                  //             color: Colors.grey[500],
                  //           ),
                  //           title: Text(
                  //             "From where?",
                  //             textAlign: TextAlign.left,
                  //             style: TextStyle(
                  //               fontSize: 20.0,
                  //               fontFamily: "Ubuntu",
                  //               fontWeight: FontWeight.w500,
                  //               height: 1.6,
                  //             ),
                  //           ),
                  //           subtitle: TextField(
                  //               decoration: InputDecoration(
                  //                   hintText: "Input pickup location...")),
                  //           contentPadding: EdgeInsets.only(left: 20),
                  //           dense: true,
                  //         ),
                  //         SizedBox(height: 10),
                  //         ListTile(
                  //           leading: Transform.rotate(
                  //             angle: 120,
                  //             child: Icon(
                  //               Icons.navigation_rounded,
                  //               color: Colors.grey[500],
                  //             ),
                  //           ),
                  //           title: Text(
                  //             "To where?",
                  //             textAlign: TextAlign.left,
                  //             style: TextStyle(
                  //               fontSize: 20.0,
                  //               fontFamily: "Ubuntu",
                  //               fontWeight: FontWeight.w500,
                  //               height: 1.6,
                  //             ),
                  //           ),
                  //           subtitle: TextField(
                  //               decoration: InputDecoration(
                  //                   hintText: "Input destination location...")),
                  //           contentPadding: EdgeInsets.only(left: 20),
                  //           dense: true,
                  //         ),
                  //         Expanded(child: SizedBox()),
                  //         Hero(
                  //           tag: "btn",
                  //           flightShuttleBuilder: _flightShuttleBuilder,
                  //           child: GestureDetector(
                  //             child: Container(
                  //                 height: 50,
                  //                 alignment: Alignment.center,
                  //                 margin: EdgeInsets.only(
                  //                     bottom: 18, left: 25, right: 25),
                  //                 decoration: BoxDecoration(
                  //                   color: AppColors.primaryText,
                  //                   boxShadow: [Shadows.secondaryShadow],
                  //                   borderRadius: Radii.kRoundpxRadius,
                  //                 ),
                  //                 child: Text('FIND RIDER',
                  //                     style: TextStyle(
                  //                         fontSize: 16,
                  //                         fontFamily: 'Ubuntu',
                  //                         color: Colors.white,
                  //                         fontWeight: FontWeight.w500))),
                  //             onTap: () {
                  //               Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         OTPVerification(authId: null)),
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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

  Widget notifPanel() => Hero(
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
                    width: 44,
                    height: 44,
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
                SizedBox(height: 25),
              ],
            ),
            SizedBox(width: 15),
          ]),
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
