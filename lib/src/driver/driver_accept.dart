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
                        "Delivery takes 14 mins",
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'QLink bike ',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: "Ubuntu",
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400,
                                        height: 1.5),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(Icons.circle,
                                          size: 8, color: Colors.grey),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Plate Number: RV745T',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: "Ubuntu",
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400,
                                        height: 1.5),
                                  ),
                                ],
                              ),
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
                              text: 'Your driver is ',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  height: 1.6),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Confidence Yobo',
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

  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: new Wrap(
              children: <Widget>[
                Container(margin: EdgeInsets.only(bottom: 10, top: 15),
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
                  leading: Icon(Icons.circle, size: 10, color: Colors.grey[500]),
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
                  leading: Icon(Icons.circle, size: 10, color: Colors.grey[500]),
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
                  leading: Icon(Icons.circle, size: 10, color: Colors.grey[500]),
                  title: new Text('User not willing to adhere the system guidelines',
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
        }
    );
  }
}
