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
          appBar: AppBar(
            title: Text(title),
            brightness: Brightness.light,
            actions: [
              selectedPage == 0
                  ? Container()
                  : FlatButton(
                      onPressed: () {},
                      color: selectedPage == 1 ? Colors.yellow : Colors.green,
                      child: Text(selectedPage == 1 ? 'Add driver' : 'Withdraw')),
            ],
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu_rounded, color: Colors.brown,),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
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
                      title = 'New Requests';
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
                      title = 'Drivers';
                      btnText = 'Add drivers';
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
                      title = 'Wallet';
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
