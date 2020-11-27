import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/HP/Desktop/Development/MobileDev/picker_app/lib/src/utils/show_up_animation.dart';
import 'package:pickrr_app/src/driver/driver_tabs.dart';
import 'package:pickrr_app/src/helpers/constants.dart';

class DriverBoard extends StatelessWidget {
  final int delayAmount = 500;
  final bgImage = 'assets/flare/pickrr.flr';

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              new FlareActor(bgImage,
                  alignment: Alignment.center, fit: BoxFit.cover),
              Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: Align(
                  child: Container(
                    // color: Colors.black12,
                      height: MediaQuery.of(context).size.height / 2.4,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 30, bottom: 30, right: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ShowUp(
                              child: Text(
                                'Pickrr Driver',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 27,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w900),
                              ),
                              delay: delayAmount + 800,
                            ),
                            SizedBox(height: 12),
                            ShowUp(
                              child: Text(
                                'Be your own boss?\nStart today',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w700),
                              ),
                              delay: delayAmount + 1100,
                            ),
                            SizedBox(height: 12),
                            ShowUp(
                              child:Text(
                                'Pickrr Driver gives you access to more customers nearby who need your delivery services.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w500,
                                    height: 1.3),
                              ),
                              delay: delayAmount + 1500,
                            ),
                            SizedBox(height: 20),
                            ShowUp(
                              child: GestureDetector(
                                child: Container(
                                  height: 47,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColor.primaryText,
                                          AppColor.primaryText,
                                          Colors.lightBlueAccent
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(35.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                          AppColor.primaryText.withOpacity(0.25),
                                          spreadRadius: 2,
                                          blurRadius: 20,
                                          offset: Offset(0, 10),
                                        )
                                      ]),
                                  child: Center(
                                    child: Text(
                                      'Get started',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        letterSpacing: 0.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DriverTabs()),
                                  );
                                },
                              ),
                              delay: delayAmount + 2400,
                            ),
                          ])),
                ),
              ),
            ],
          )),
    );
  }
}

Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
    ) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}
