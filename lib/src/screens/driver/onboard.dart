import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/utils/show_up_animation.dart';
import 'package:pickrr_app/src/helpers/constants.dart';

class DriverOnboard extends StatelessWidget {
  final int delayAmount = 500;
  final bgImage = 'assets/flare/pickrr.flr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            new FlareActor(bgImage,
                alignment: Alignment.center, fit: BoxFit.cover),
            Positioned(
                top: 43,
                left: 0,
                right: 0,
                child: Align(
                    child: Row(children: [
                  Expanded(child: SizedBox()),
                  FlatButton(
                      child: Text('Cancel',
                          style: TextStyle(
                            color: AppColor.primaryText,
                            fontFamily: 'Ubuntu',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          )),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(width: 5),
                ]))),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: Align(
                child: Container(
                    height: MediaQuery.of(context).size.height / 2.4,
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
                                'Gentle hands,\nfast tyres',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 27,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            delay: delayAmount + 800,
                          ),
                          SizedBox(height: 12),
                          ShowUp(
                            child: Hero(
                                tag: 'body_text_splash',
                                child: Text(
                                  'We are the people you call for when you want your package delivered safe and fast.',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w500,
                                      height: 1.3),
                                )),
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
                                        color: AppColor.primaryText
                                            .withOpacity(0.25),
                                        spreadRadius: 2,
                                        blurRadius: 20,
                                        offset: Offset(0, 10),
                                      )
                                    ]),
                                child: Center(
                                  child: Text(
                                    'Apply Now',
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
                                Navigator.pushNamed(
                                    context, '/DriverApplication');
                              },
                            ),
                            delay: delayAmount + 2400,
                          ),
                        ])),
              ),
            ),
          ],
        ));
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
