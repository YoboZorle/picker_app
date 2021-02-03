import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_drivers/business_drivers.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_wallet/business_wallet.dart';
import 'package:pickrr_app/src/screens/business/tabs/ride_requests/new_request.dart';

class BusinessHomePage extends StatefulWidget {
  BusinessHomePage() : super();

  @override
  BusinessHomePageState createState() => BusinessHomePageState();
}

class BusinessHomePageState extends State<BusinessHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            NewRequest(),
            BusinessDrivers(),
            BusinessWallet(),
          ],
          controller: controller,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
              ),
            ],
          ),
          child: Material(
            color: Colors.white,
            child: TabBar(
              indicatorWeight: 2,
              indicatorPadding: EdgeInsets.only(left: 50, right: 50, top: 50),
              indicatorColor: AppColor.primaryText,
              labelColor: AppColor.primaryText,
              unselectedLabelColor: Colors.grey[400],
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.favorite),
                ),
                Tab(
                  icon: Icon(Icons.directions_bike_rounded),
                ),
                Tab(
                  icon: Icon(Icons.account_balance_wallet_rounded),
                ),
              ],
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}
