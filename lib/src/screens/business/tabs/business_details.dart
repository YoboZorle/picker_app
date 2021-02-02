import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/widgets/image.dart';

class BusinessDetails extends StatefulWidget {
  BusinessDetailsWidget createState() => BusinessDetailsWidget();
}

class BusinessDetailsWidget extends State {
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
                  'Business Profile',
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
                    icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black, size: 20,)),
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
                        child: ListTile(
                          title: Text(
                            'Port harcourt',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                height: 1.6),
                          ),
                          subtitle: Text(
                            'State/City',
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
