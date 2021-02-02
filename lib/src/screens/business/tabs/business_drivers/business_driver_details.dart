import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class BusinessDriverDetails extends StatefulWidget {
  BusinessDriverDetailsWidget createState() => BusinessDriverDetailsWidget();
}

class BusinessDriverDetailsWidget extends State {
  bool _switchValues = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                centerTitle: true,
                title: Text(
                  'Your Driver\'s Profile',
                  style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                      size: 20,
                    )),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 10),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15),
                        child: ListTile(
                          leading: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://i.pinimg.com/originals/30/3c/1d/303c1d159727b81dc4ef644bd079af82.jpg")))),
                          title: Text(
                            "Ruzz Logistics",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                height: 1.6),
                          ),
                          subtitle: Text(
                            'Business name',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                height: 1.5),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: ListTile(
                          title: Text(
                            'yobozorle@gmail.com',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                height: 1.6),
                          ),
                          subtitle: Text(
                            'Business email',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                height: 1.5),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: ListTile(
                          title: Text(
                            '+234 908 26737',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                height: 1.6),
                          ),
                          subtitle: Text(
                            'Business phone number',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                height: 1.5),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: ListTileSwitch(
                          contentPadding: EdgeInsets.all(0),
                          value: _switchValues,
                          onChanged: (value) {
                            setState(() {
                              _switchValues = value;
                            });
                          },
                          toggleSelectedOnValueChange: true,
                          subtitle: Text(
                              'Toggle button to activate or deactivate your driver.',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "Ubuntu",
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5)),
                          switchActiveColor: Colors.green,
                          switchType: SwitchType.material,
                          title: Text(  _switchValues == false ?  'Driver Unavailable' : 'Driver Available',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Ubuntu",
                                  fontWeight: FontWeight.w500,
                                  height: 1.6)),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 20),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'LOG OUT',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    height: 1.6),
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.all(0),
                          dense: true,
                          onTap: () {
                            ConfirmAlertBoxDark(
                                context: context,
                                title: 'Are you sure you want to leave?',
                                titleTextColor: Colors.white,
                                icon: Icons.eighteen_mp,
                                infoMessage: '',
                                onPressedYes: () {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
