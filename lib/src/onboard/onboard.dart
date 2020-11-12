import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/anim/show_up_animation.dart';
import 'package:pickrr_app/src/auth/phone_login.dart';
import 'package:pickrr_app/src/values/values.dart';

class Onboard extends StatelessWidget {
  final int delayAmount = 500;
  final bgImage = 'assets/flare/splash_kargo_bg.flr';


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
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 30, bottom: 30, right: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ShowUp(
                              child: Hero(
                                tag: 'input_phon_auth_title',
                                flightShuttleBuilder: _flightShuttleBuilder,
                                child: Text(
                                  'You\'re moving what\nmatters.',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 27,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              delay: delayAmount + 1000,
                            ),
                            SizedBox(height: 12),
                            ShowUp(
                              child: Hero(
                                tag: 'body_text_splash',
                                child: Text(
                                  'We are building new ways to support you with smarter deliveries, flexibility\nand quick pay.',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w500,
                                      height: 1.3),
                                ),
                              ),
                              delay: delayAmount + 1500,
                            ),
                            SizedBox(height: 20),
                            ShowUp(
                              child: GestureDetector(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryText,
                                          AppColors.primaryText,
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
                                      AppColors.primaryText.withOpacity(0.25),
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
                                        fontSize: 17,
                                        letterSpacing: 0.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PhoneLogin()),
                                  );
                                },
                              ),
                              delay: delayAmount + 2300,
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
