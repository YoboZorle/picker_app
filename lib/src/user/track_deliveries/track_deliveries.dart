import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/utils/transitionAppbar/transition_appbar.dart';

class TrackDeliveries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cryptoPortfolioItem(String img, String name, double amount, String rate,
            String percentage) =>
        Card(
          elevation: 0,
          child: InkWell(
            onTap: () => print("tapped"),
            child: Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 15.0),
                      // child: Icon(icon, color: Colors.grey),
                      child: CircularProfileAvatar(
                        img,
                        radius: 25,
                        backgroundColor: Colors.grey[200],
                        // sets initials text, set your own style, default Text('')
                        borderColor: Colors
                            .brown, // sets border color, default Colors.white
                        elevation:
                            0.0, // sets elevation (shadow of the profile picture), default value is 0.0
                        cacheImage:
                            true, // allow widget to cache image against provided url
                        onTap: () {
                          print('yea');
                        }, // sets on tap
                        showInitialTextAbovePicture:
                            false, // setting it true will show initials text above profile picture, default false
                      )),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                  fontFamily: "Ubuntu",
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text("\u20A6$amount",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("$rate",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal)),
                            Text("+ \u20A6$percentage",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red[500],
                                ))
                          ],
                        )
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
        );
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            TransitionAppBar(
              extent: 100,
              avatar: Text("Track Deliveries",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Ubuntu',
                    fontSize: 25,
                  )),
              title: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Icon(Icons.search),
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.black,
                      autofocus: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          hintText: "Enter tracking ID",
                          border: InputBorder.none,
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.transparent),
                            borderRadius: new BorderRadius.circular(2),
                          )),
                    ),
                  ),
                ]),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 8, left: 8),
                          child: Text('Track',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.w600)),
                        ),
                        color: AppColors.primaryText,
                        textColor: AppColors.primaryText,
                        onPressed: () {},
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 40),
                  Center(child: Text("Tracked deliveries appear here")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
