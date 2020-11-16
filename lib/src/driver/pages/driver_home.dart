import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:pickrr_app/src/values/values.dart';

import '../../home.dart';

class DriverHome extends StatefulWidget {
  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(4.814041, 7.002759),
    zoom: 15.5746,
  );

  Completer<GoogleMapController> _controller = Completer();

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
                  color: AppColors.primaryText,
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
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              )
            ]),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          CustomHeader(),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                notifPanel(),
                Container(
                  height: MediaQuery.of(context).size.height / 2.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      Shadows.primaryShadow,
                    ],
                  ),
                  child: Expanded(
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
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20),
                            new Text(
                              "New pickup available!",
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  height: 1.6),
                            ),
                          ],
                        ),
                        Container(
                            height: 0.8,
                            margin: EdgeInsets.only(top: 10, bottom: 15),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300]),
                        ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://i.pinimg.com/originals/f5/1b/e3/f51be323ae96b07a34a5f858402ae040.jpg")),
                          title: Text(
                            "Amaka Johnson",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Ubuntu",
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                            ),
                          ),
                          subtitle: Text(
                            "107 Victoria Street, Port harcourt",
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: "Ubuntu",
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                          isThreeLine: true,
                          contentPadding: EdgeInsets.only(left: 20),
                          dense: true,
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                            height: 50,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                bottom: 15, left: 25, right: 25),
                            decoration: BoxDecoration(
                              color: AppColors.primaryText,
                              boxShadow: [Shadows.secondaryShadow],
                              borderRadius: Radii.kRoundpxRadius,
                            ),
                            child: Text('Accept',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500))),
                        Container(
                            height: 30,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                bottom: 25, left: 25, right: 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: Radii.kRoundpxRadius,
                            ),
                            child: Text('Decline',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
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
  );
}

/// Search text field plus the horizontally scrolling categories below the text field
class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomerAppBar(),
      ],
    );
  }
}

class CustomerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool status = false;
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
                 SizedBox(height: 45,
                   child: LiteRollingSwitch(
                        value: true,
                        textOn: 'Online',
                        textOff: 'Offline',
                        colorOn: Colors.green,
                        colorOff: Colors.grey[400],
                        iconOn: Icons.lightbulb_outline,
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
