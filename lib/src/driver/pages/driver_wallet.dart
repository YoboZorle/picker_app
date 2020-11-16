import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/values/values.dart';

class DriverWallet extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    cryptoPortfolioItem(String img, String name, double amount, String rate,
        String percentage) =>
        Card(
          elevation: 1.0,
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
                    'Become a rider',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Ubuntu",
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  subtitle: Text(
                    'Earn money on your schedule',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Ubuntu",
                        color: Colors.grey[200],
                        fontSize: 15),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 17, color: Colors.grey[200]),
                ),
              )
            ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryText,
                        AppColors.primaryText,
                        Colors.lightGreen,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      // stops: [0.0, 0.1],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * .35,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 100, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40),
                      Text(
                        r"Wallet Ballance",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "Ubuntu",
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\u20A625,300.00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.w800)),
                          RaisedButton(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 8, left: 8),
                              child: Text('Withdraw',
                                  style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontSize: 17.0,
                                      fontFamily: "Ubuntu",
                                      fontWeight: FontWeight.w600)),
                            ),
                            color: Colors.white,
                            textColor: AppColors.primaryText,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .75,
                  color: Colors.grey,
                )
              ],
            ),
            SafeArea(
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
                            // Scaffold.of(context).openDrawer();
                            _scaffoldKey.currentState.openDrawer();
                          }),
                    ],
                  )),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .28,
                  right: 10.0,
                  left: 10.0),
              child: new Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: <Widget>[
                    cryptoPortfolioItem(
                        'https://www.bellanaija.com/wp-content/uploads/2016/04/seunlogan_topnigerianmodel_bellanaija_2016_01.jpg',
                        "Uche Chijioke",
                        410.80,
                        'Oct 31, 2020',
                        "82.19(92%)"),
                    cryptoPortfolioItem(
                        'https://i.pinimg.com/originals/1d/70/5a/1d705a159905b3e2d7af4b27299be216.jpg',
                        "Eyin Nwig",
                        1089.86,
                        'Nov 1, 2020',
                        "13.10(2.3%)"),
                    cryptoPortfolioItem(
                        'https://images.unsplash.com/photo-1586171984069-1dbce3573a10?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                        "Amarachi Chris",
                        22998.13,
                        '3 Nov, 2020',
                        "120(3.6%)"),
                    cryptoPortfolioItem(
                        'https://asset1.modelmanagement.com/mm-eyJ0Ijp7InIiOiIzMjAi/fSwiaWQiOiJpNjYyMTM5/MyIsImYiOiJqcGcifQ;;.jpg',
                        "Cindy Stevie",
                        410.80,
                        '3 Nov, 2020',
                        "82.19(92%)"),
                    cryptoPortfolioItem(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTOjDgqRFB7Aqe20oFvMqdH9SLR8_GyumBxZw&usqp=CAU',
                        "Enel Amadi",
                        1089.86,
                        '4 Nov, 2020',
                        "13.10(2.3%)"),
                    cryptoPortfolioItem(
                        'https://modelstalk.ng/wp-content/uploads/2019/05/IMG-20190509-WA0009.jpg',
                        "Clara Bassey",
                        22998.13,
                        '5 Nov, 2020',
                        "120(3.6%)"),
                    cryptoPortfolioItem(
                        'https://shutterfinger.typepad.com/.a/6a00e551a6244a8833019affd0eb14970d-pi',
                        "Dave Smith",
                        410.80,
                        '6 Nov, 2020',
                        "82.19(92%)"),
                    cryptoPortfolioItem(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSPiXY1VKY8ZFJjPPVRCR6J13DMji3czuNdFQ&usqp=CAU',
                        "Jack Bara",
                        1089.86,
                        '6 Nov, 2020',
                        "13.10(2.3%)"),
                    cryptoPortfolioItem(
                        'https://sbly-web-prod-shareably.netdna-ssl.com/wp-content/uploads/2018/11/26204648/nigerian13.jpg',
                        "Cassie Tassie",
                        22998.13,
                        '6 Nov, 2020',
                        "120(3.6%)"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
