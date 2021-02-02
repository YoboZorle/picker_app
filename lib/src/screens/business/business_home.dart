import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_drivers/business_drivers.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_wallet/business_wallet.dart';
import 'package:pickrr_app/src/screens/business/tabs/ride_requests/new_request.dart';
import 'package:pickrr_app/src/screens/star_rating/rate_driver.dart';

import 'tabs/business_details.dart';

class BusinessHomePage extends StatefulWidget {
  BusinessHomePage({Key key}) : super(key: key);
  _BusinessHomePageState createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  PageController _myPage;
  var selectedPage;
  String title;
  String btnText;

  @override
  void initState() {
    super.initState();
    _myPage = PageController(initialPage: 0);
    selectedPage = 0;
    title = 'New Requests';
    btnText = 'Add driver';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Ubuntu')),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              Row(
                children: [
                  selectedPage == 0
                      ? Container()
                      : RaisedButton(
                          elevation: 8,
                          onPressed: () {},
                          color: selectedPage == 1
                              ? AppColor.primaryText
                              : AppColor.primaryText,
                          child: Text(
                              selectedPage == 1 ? 'Add driver' : 'Withdraw',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Ubuntu'))),
                  SizedBox(width: 20)
                ],
              ),
            ],
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu_rounded, color: Colors.black),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          drawer: Drawer(
              elevation: 20.0,
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.grey[300],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return BusinessDetails();
                            },
                            fullscreenDialog: true,
                          ));
                    },
                    child: UserAccountsDrawerHeader(
                      accountName: Text('Ruzz Logistics',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              fontFamily: 'Ubuntu',
                              height: 1.3)),
                      accountEmail: Text('Business account',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Ubuntu')),
                      currentAccountPicture: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://i.pinimg.com/originals/30/3c/1d/303c1d159727b81dc4ef644bd079af82.jpg")))),
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.account_circle_rounded,
                      color: Colors.grey[400],
                    ),
                    title: Text('Support',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Ubuntu')),
                    onTap: () {
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.star_rate_rounded,
                      color: Colors.grey[400],
                    ),
                    title: Text('Star rating',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Ubuntu')),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return RateDriver();
                            },
                            fullscreenDialog: true,
                          ));
                    },
                  ),
                  SizedBox(height: 35),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
                    child: RaisedButton(
                        elevation: 12,
                        onPressed: () {
                          Navigator.pushNamed(context, '/HomePage');
                        },
                        color: AppColor.primaryText,
                        child: Container(
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text('Go back to Personal account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Ubuntu')),
                        )),
                  ),
                ],
              )),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _myPage,
            children: <Widget>[
              NewRequest(),
              BusinessDrivers(),
              BusinessWallet(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: selectedPage == 0 ? Colors.blue : Colors.grey,
                  onPressed: () {
                    _myPage.jumpToPage(0);
                    setState(() {
                      selectedPage = 0;
                      title = 'Ride Requests';
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.directions_bike_rounded),
                  color: selectedPage == 1 ? Colors.blue : Colors.grey,
                  onPressed: () {
                    _myPage.jumpToPage(1);
                    setState(() {
                      selectedPage = 1;
                      title = 'My Drivers';
                      btnText = 'Add drivers';
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.account_balance_wallet_rounded,
                  ),
                  color: selectedPage == 2 ? Colors.blue : Colors.grey,
                  onPressed: () {
                    _myPage.jumpToPage(2);
                    setState(() {
                      selectedPage = 2;
                      title = 'My Balance';
                      btnText = 'Withdraw';
                    });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
