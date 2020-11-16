import 'package:flutter/material.dart';
import 'package:pickrr_app/src/values/values.dart';
import 'pages/driver_home.dart';
import 'pages/driver_prof.dart';
import 'pages/driver_wallet.dart';

class DriverTabs extends StatefulWidget {
  @override
  _DriverTabsState createState() => _DriverTabsState();
}

class _DriverTabsState extends State<DriverTabs> {
  List<Widget> originalList;
  Map<int, bool> originalDic;
  List<Widget> listScreens;
  List<int> listScreensIndex;

  int tabIndex = 0;
  Color tabColor = Colors.grey[500];
  Color selectedTabColor = AppColors.primaryText;

  @override
  void initState() {
    super.initState();
    originalList = [
      DriverHome(),
      DriverWallet(),
      DriverProf(),
    ];
    originalDic = {0: true, 1: false, 2: false};
    listScreens = [originalList.first];
    listScreensIndex = [0];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: AppColors.primaryText,
      home: Scaffold(
        body: IndexedStack(
            index: listScreensIndex.indexOf(tabIndex), children: listScreens),
        bottomNavigationBar: _buildTabBar(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _selectedTab(int index) {
    if (originalDic[index] == false) {
      listScreensIndex.add(index);
      originalDic[index] = true;
      listScreensIndex.sort();
      listScreens = listScreensIndex.map((index) {
        return originalList[index];
      }).toList();
    }

    setState(() {
      tabIndex = index;
    });
  }

  Widget _buildTabBar() {
    var listItems = [
      BottomAppBarItem(iconData: Icons.directions_bike_sharp, text: 'Discover'),
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
      color: Theme.of(context).primaryColor,
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
