import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/values/values.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverAccept extends StatefulWidget {
  @override
  _DriverAcceptState createState() => _DriverAcceptState();
}

class _DriverAcceptState extends State<DriverAccept> {
  GoogleMapController myMapController;
  final Set<Marker> _markers = new Set();
  static const LatLng _mainLocation = const LatLng(4.814340, 7.000848);
  double amount = 500;
  final currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
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
                    SafeArea(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 15, 16, 8),
                          child: Hero(
                            tag: "nav",
                            flightShuttleBuilder: _flightShuttleBuilder,
                            child: GestureDetector(
                                child: Container(
                                  // color: Colors.yellow,
                                  padding: EdgeInsets.only(right: 10),
                                  child: Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.arrow_back,
                                          size: 23,
                                        ),
                                      )),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                }),
                          )),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: orderLocationDetailsPanel()),
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
                      new Text(
                        "Delivery will take 14 mins",
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Ubuntu",
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            height: 1.35),
                      ),
                      SizedBox(height: 15),
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
                            Text(
                              "Transaction ID:",
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "87AGB346",
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  height: 1.6),
                            ),
                          ],
                        ),
                        subtitle: RichText(
                          text: TextSpan(
                              text: 'Your sender name: ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Confidence',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: "Ubuntu",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      height: 1.6),
                                )
                              ]),
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                        dense: true,
                      ),
                      Container(height: 0.4,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[400],
                      margin: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 3)),
                      ListTile(
                        leading: Icon(Icons.location_on_rounded, color: Colors.redAccent, size: 22),
                        title:   Text('KoWork NG, Sani Abacha Road, Port harcourt, Nigeria',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                        ),
                        contentPadding: EdgeInsets.only(left: 20, right: 20),
                        dense: true,
                      ),
                      ListTile(
                        leading: Transform.rotate(
                          angle: 120,
                          child: Icon(
                            Icons.navigation_rounded,
                            color: Colors.greenAccent,
                            size: 22,
                          ),
                        ),
                        title:   Text('20 Rex Lawson Street, Borikiri, Port harcourt, Nigeria',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                        ),
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
                                bottom: 10, left: 25, right: 25, top: 25),
                            decoration: BoxDecoration(
                              color: AppColors.primaryText,
                              boxShadow: [Shadows.secondaryShadow],
                              borderRadius: Radii.kRoundpxRadius,
                            ),
                            child: Text('Start Ride',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          ),
                          onTap: () => launch("tel://08161654006"),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          height: 45,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              bottom: 10, left: 25, right: 25, top: 0),
                          child: Text('Cancel ride',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500)),
                        ),
                        onTap: () {
                          _settingModalBottomSheet(context);
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    )));
  }

  Set<Marker> myMarker() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_mainLocation.toString()),
        position: _mainLocation,
        infoWindow: InfoWindow(
          title: 'Bikers City',
          snippet: 'George Howfa na :)',
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
                          color: AppColors.primaryText,
                          child: Icon(Icons.directions_bike_sharp,
                              color: Colors.white)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "7km",
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: new Wrap(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(bottom: 10, top: 15),
                    child: Center(
                      child: Text('Reason For Cancellation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              height: 1.35)),
                    )),
                new ListTile(
                  dense: true,
                  leading:
                      Icon(Icons.circle, size: 10, color: Colors.grey[500]),
                  title: new Text('Under-aged user making order',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          height: 1.35)),
                  onTap: () => {},
                ),
                new ListTile(
                  dense: true,
                  leading:
                      Icon(Icons.circle, size: 10, color: Colors.grey[500]),
                  title: new Text('Could not find user at the location',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          height: 1.35)),
                  onTap: () => {},
                ),
                new ListTile(
                  dense: true,
                  leading:
                      Icon(Icons.circle, size: 10, color: Colors.grey[500]),
                  title: new Text(
                      'User not willing to adhere the system guidelines',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          height: 1.35)),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }
}
