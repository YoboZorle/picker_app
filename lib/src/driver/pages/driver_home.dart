import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:pickrr_app/src/driver/driver_accept.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class DriverHome extends StatefulWidget {
  DriverHome({Key key}) : super(key: key);

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController myMapController;
  final Set<Marker> _markers = new Set();
  static const LatLng _mainLocation = const LatLng(4.814340, 7.000848);

  bool arrived = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(children: <Widget>[
              SizedBox(height: 30),
              ListTile(
                leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80")),
                title: Text(
                  'David Ejiro',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "Ubuntu",
                      fontSize: 18),
                ),
                subtitle: Text(
                  'Driver profile',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Ubuntu",
                      fontSize: 15),
                ),
              ),
              Container(
                  height: 0.7,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[300]),
              ListTile(
                title: Text(
                  'Track Deliveries',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Ubuntu",
                      fontSize: 18),
                ),
                leading: Icon(Icons.track_changes),
                dense: false,
              ),
              ListTile(
                title: Text(
                  'Ride History',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Ubuntu",
                      fontSize: 18),
                ),
                leading: Icon(Icons.history),
              ),
              ListTile(
                title: Text(
                  'Support',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Ubuntu",
                      fontSize: 18),
                ),
                leading: Icon(Icons.support_agent),
              ),
              ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Ubuntu",
                      fontSize: 18),
                ),
                leading: Icon(Icons.read_more),
              ),
              Expanded(child: SizedBox()),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primaryText,
                ),
                margin: EdgeInsets.only(bottom: 40),
                child: ListTile(
                  title: Text(
                    'Back to user',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Ubuntu",
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  subtitle: Text(
                    'Go back to ordering rides',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Ubuntu",
                        color: Colors.grey[200],
                        fontSize: 15),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 17, color: Colors.grey[200]),
                  onTap: () {
                    Navigator.pushNamed(context, '/HomePage');
                  },
                ),
              )
            ]),
          ),
        ),
      ),
      body: Column(
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
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: arrived ? orderLocationDetailsPanel() : notifPanel())
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
                    margin: EdgeInsets.only(top: 15, bottom: 18),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  Text(
                    arrived ? "Meet and Pickup" : "New Request!",
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Ubuntu",
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        height: 1.35),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    trailing: Column(
                      children: [
                        Expanded(
                          child: Container(
                              width: 70.0,
                              height: 70.0,
                              margin: EdgeInsets.only(right: 15),
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://monologueblogger.com/wp-content/uploads/2015/05/Brody-At-Dusk-Male-Drama-Monologue.jpg")))),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Name:',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5),
                              ),
                              TextSpan(
                                text: ' Mike Anderson ',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5),
                              ),
                              // WidgetSpan(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(4.0),
                              //     child: Icon(Icons.circle,
                              //         size: 8, color: Colors.grey),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    subtitle: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Pickup:',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              height: 1.5),
                        ),
                        TextSpan(
                          text: ' 12B Sani Abach Road 5',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              height: 1.6),
                        ),
                      ]),
                    ),
                    contentPadding: EdgeInsets.only(left: 20),
                    dense: true,
                  ),
                  arrived
                      ? GestureDetector(
                          child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                bottom: 5, left: 25, right: 25, top: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: Radii.kRoundpxRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone_rounded,
                                    color: Colors.black, size: 20),
                                SizedBox(width: 8),
                                Text('Call 08161654006',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Ubuntu',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                          onTap: () => launch("tel://08161654006"),
                        )
                      : SizedBox(),
                  arrived
                      ? Hero(
                          tag: "btn",
                          flightShuttleBuilder: _flightShuttleBuilder,
                          child: GestureDetector(
                            child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 25, right: 25, top: 18),
                              decoration: BoxDecoration(
                                color: AppColor.primaryText,
                                boxShadow: [Shadows.secondaryShadow],
                                borderRadius: Radii.kRoundpxRadius,
                              ),
                              child: Text('Arrived',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DriverAccept()),
                              );
                              // setState(() {
                              //   arrived = !arrived;
                              // });
                            },
                          ),
                        )
                      : Hero(
                          tag: "btn",
                          flightShuttleBuilder: _flightShuttleBuilder,
                          child: GestureDetector(
                            child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(
                                  bottom: 10, left: 25, right: 25, top: 18),
                              decoration: BoxDecoration(
                                color: AppColor.primaryText,
                                boxShadow: [Shadows.secondaryShadow],
                                borderRadius: Radii.kRoundpxRadius,
                              ),
                              child: Text('Accept',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Ubuntu',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => DriverAccept()),
                              // );
                              setState(() {
                                arrived = !arrived;
                              });
                            },
                          ),
                        ),
                  arrived
                      ? SizedBox()
                      : GestureDetector(
                          child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                bottom: 10, left: 25, right: 25, top: 0),
                            child: Text('Decline ride',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500)),
                          ),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => AdminDriver()),
                            // );
                          },
                        ),
                ],
              )),
        ],
      ),
    );
  }

  Widget notifPanel() => Container(
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
                  child: Text('7',
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
      );

  Widget orderLocationDetailsPanel() => Hero(
        tag: "orderLocation",
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            Expanded(child: SizedBox()),
            Column(
              children: [
                Container(
                  // width: 42,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12.0,
                        offset: Offset(0.0, 5.0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                          height: 35,
                          width: 45,
                          // padding: EdgeInsets.all(5),
                          color: AppColor.primaryText,
                          child: Icon(Icons.directions_bike_sharp,
                              color: Colors.white)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "2 mins",
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
            SizedBox(width: 15),
          ]),
        ),
      );

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

class CustomerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 15, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  child: Container(
                    // color: Colors.yellow,
                    padding: EdgeInsets.only(right: 10),
                    child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.menu_sharp,
                            size: 25,
                          ),
                        )),
                  ),
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                    // _scaffoldKey.currentState.openDrawer();
                  }),
              Row(
                children: [
                  SizedBox(
                    height: 45,
                    child: LiteRollingSwitch(
                      value: true,
                      textOn: 'Online',
                      textOff: 'Offline',
                      colorOn: AppColor.primaryText,
                      colorOff: Colors.grey[400],
                      iconOn: Icons.directions_bike,
                      iconOff: Icons.power_settings_new,
                      onChanged: (bool state) {
                        print('turned ${(state) ? 'on' : 'off'}');
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
