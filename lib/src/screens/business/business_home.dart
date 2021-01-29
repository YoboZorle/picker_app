import 'package:flutter/material.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_drivers.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_wallet.dart';
import 'package:pickrr_app/src/screens/business/tabs/new_request.dart';

class BusinessHomePage extends StatefulWidget {
  BusinessHomePage({Key key}) : super(key: key);
  _BusinessHomePageState createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  PageController _myPage;
  var selectedPage;

  @override
  void initState() {
    super.initState();
    _myPage = PageController(initialPage: 0);
    selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.star),
                color: selectedPage == 1 ? Colors.blue : Colors.grey,
                onPressed: () {
                  _myPage.jumpToPage(1);
                  setState(() {
                    selectedPage = 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                ),
                color: selectedPage == 2 ? Colors.blue : Colors.grey,
                onPressed: () {
                  _myPage.jumpToPage(2);
                  setState(() {
                    selectedPage = 2;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
