import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/driver/driver_status/bloc.dart';
import 'package:pickrr_app/src/blocs/ride/orders/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'driver_home.dart';
import 'profile.dart';
import 'driver_wallet.dart';

class DriverTabs extends StatefulWidget {
  @override
  _DriverTabsState createState() => _DriverTabsState();
}

class _DriverTabsState extends State<DriverTabs> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final List<Widget> _navPages = [
    MultiBlocProvider(providers: [
      BlocProvider<DriverStatusBloc>(create: (_) => DriverStatusBloc()),
      BlocProvider<RideOrdersBloc>(
          create: (_) => RideOrdersBloc()..add(OrdersFetched()))
    ], child: DriverHome(key: PageStorageKey('DriverHome'))),
    DriverWallet(key: PageStorageKey('DriverWallet')),
    DriverProfile(key: PageStorageKey('DriverProfile'))
  ];
  int tabIndex = 0;
  Color tabColor = Colors.grey[500];
  Color selectedTabColor = AppColor.primaryText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: _navPages[tabIndex],
        bucket: _bucket,
      ),
      bottomNavigationBar: _buildTabBar(),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  void _selectedTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  Widget _buildTabBar() {
    var listItems = [
      BottomAppBarItem(
          iconData: Icons.directions_bike_sharp, text: 'DriverHome'),
      BottomAppBarItem(iconData: Icons.account_balance_wallet, text: 'Wallet'),
      BottomAppBarItem(iconData: Icons.person, text: 'Profile'),
    ];

    var items = List.generate(listItems.length, (int index) {
      return _buildTabItem(
        item: listItems[index],
        index: index,
        onPressed: _selectedTab,
      );
    });

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: Colors.white,
    );
  }

  Widget _buildTabItem({
    BottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    var color = tabIndex == index ? selectedTabColor : tabColor;
    return Expanded(
      child: SizedBox(
        height: 60,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: 24),
                Text(
                  item.text,
                  style: TextStyle(color: color, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomAppBarItem {
  BottomAppBarItem({this.iconData, this.text});

  IconData iconData;
  String text;
}
