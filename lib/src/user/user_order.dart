import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/auth/otp_verification.dart';
import 'package:pickrr_app/src/user/receiver_details.dart';
import 'package:pickrr_app/src/values/values.dart';

class UserOrder extends StatefulWidget {
  @override
  _UserOrderState createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  GoogleMapController myMapController;
  final Set<Marker> _markers = new Set();
  static const LatLng _mainLocation = const LatLng(4.814340, 7.000848);
  double amount = 500;
  final currencyFormatter = NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
                                    borderRadius: BorderRadius.circular(50.0),
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
                    bottom: 0, right: 0, child: orderLocationDetailsPanel())
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
                    leading: SvgPicture.asset('assets/svg/scooter.svg',
                        height: 50, semanticsLabel: 'Acme Logo'),
                    title: Row(
                      children: [
                        new Text(currencyFormatter.format(amount),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              height: 1.35),
                        ),
                        Expanded(child: SizedBox()),
                        new Text(
                          "33 mins",
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Ubuntu",
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              height: 1.35),
                        ),
                      ],
                    ),
                    subtitle: Text('Amount and time taken for your package to be delivered successfully.',
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Ubuntu',
                            color: Colors.grey,
                            height: 1.3,
                            fontWeight: FontWeight.w400)),
                    contentPadding: EdgeInsets.only(left: 20, right: 20),
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
                              bottom: 18, left: 25, right: 25, top: 30),
                          decoration: BoxDecoration(
                            color: AppColors.primaryText,
                            boxShadow: [Shadows.secondaryShadow],
                            borderRadius: Radii.kRoundpxRadius,
                          ),
                          child: Text('Proceed',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Ubuntu',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500))),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                 UserDetails()),
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
          title: 'Bikers City',
          snippet: 'George Howfa na :)',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    return _markers;
  }

  void currency() {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
    print("CURRENCY NAME ${format.currencyName}"); // USD
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
                          "6km",
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
