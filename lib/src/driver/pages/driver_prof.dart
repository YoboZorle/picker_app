import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';

class DriverProf extends StatefulWidget {
  @override
  _DriverProfState createState() => _DriverProfState();
}

class _DriverProfState extends State<DriverProf>
    with AutomaticKeepAliveClientMixin<DriverProf> {
  @override
  void initState() {
    super.initState();
    print('initState Tab3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Driver Profile',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: "Ubuntu",
              fontWeight: FontWeight.w800,
            )),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProfileAvatar(
                "https://images.unsplash.com/photo-1563122870-6b0b48a0af09?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80",
                radius: 55,
                backgroundColor: Colors.grey[200],
                // sets initials text, set your own style, default Text('')
                borderColor:
                Colors.brown, // sets border color, default Colors.white
                elevation:
                0.0, // sets elevation (shadow of the profile picture), default value is 0.0
                cacheImage:
                true, // allow widget to cache image against provided url
                onTap: () {
                  print('yea');
                }, // sets on tap
                showInitialTextAbovePicture:
                false, // setting it true will show initials text above profile picture, default false
              ),
              SizedBox(height: 15),
              Text('David Ejiro',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.primaryText,
                    fontFamily: "Ubuntu",
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(height: 4),
              Text('1,320 finished rides',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontFamily: "Ubuntu",
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(height: 4),
              Text('Started 23rd July, 2019',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColor.primaryText,
                    fontFamily: "Ubuntu",
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('QLink',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.w700,
                      )),
                  Container(
                    height: 5,
                    width: 5,
                    margin: EdgeInsets.only(top: 3, left: 5, right: 5),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle),
                  ),
                  Text('AHD267PR',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
