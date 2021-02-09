import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/blocs/business/business_status/bloc.dart';
import 'package:pickrr_app/src/blocs/business/ride_order/bloc.dart';
import 'package:pickrr_app/src/blocs/business/riders/bloc.dart';
import 'package:pickrr_app/src/blocs/business/transaction/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/models/business.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_drivers/business_drivers.dart';
import 'package:pickrr_app/src/screens/business/tabs/business_wallet.dart';
import 'package:pickrr_app/src/screens/business/tabs/ride/new_request.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';

class BusinessHomePage extends StatefulWidget {
  BusinessHomePage() : super();

  @override
  BusinessHomePageState createState() => BusinessHomePageState();
}

class BusinessHomePageState extends State<BusinessHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  BusinessRepository _businessRepository = BusinessRepository();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _pages = [
    BlocProvider<BusinessRideOrdersBloc>(
        create: (_) => BusinessRideOrdersBloc()..add(BusinessOrdersFetched()),
        child: NewRequest()),
    BlocProvider<BusinessRidersBloc>(
      create: (_) => BusinessRidersBloc()..add(RidersFetched()),
      child: BusinessDrivers(),
    ),
    BlocProvider<BusinessTransactionBloc>(
        create: (_) =>
            BusinessTransactionBloc()..add(BusinessTransactionFetched()),
        child: BusinessWallet()),
  ];

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
    return Scaffold(
      key: _scaffoldKey,
      body: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (__, state) async {
                if (state is LoggedIn || state is DetailsUpdate) {
                  User user = state.props[0];
                  Business business = await _businessRepository
                      .getBusinessFromStorage(user.businessId);
                  if (business != null) {
                    if (state is DetailsUpdate && business.blocked) {
                      BlocProvider.of<BusinessStatusBloc>(context)
                          .add(BusinessStatusEvent.BLOCKED);
                    }
                  }
                }
              },
            ),
            BlocListener<BusinessStatusBloc, BusinessStatusState>(
              listener: (__, state) async {
                if (state is IsBlocked) {
                  Scaffold.of(context).showSnackBar(
                    new SnackBar(
                      content: new Text(
                          'Your account has been blocked. Contact admin for help'),
                    ),
                  );

                  new Future<Null>.delayed(Duration(seconds: 3), () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/HomePage', (route) => false);
                  });
                  return;
                }
              },
            ),
          ],
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            children: _pages,
            controller: controller,
          )),
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
            indicatorPadding: EdgeInsets.only(left: 50, right: 50),
            indicatorColor: AppColor.primaryText,
            labelColor: AppColor.primaryText,
            unselectedLabelColor: Colors.grey[400],
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home_filled),
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
    );
  }
}
