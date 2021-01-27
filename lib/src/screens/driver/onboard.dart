import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pickrr_app/src/utils/show_up_animation.dart';
import 'package:pickrr_app/src/helpers/constants.dart';

class DriverOnboard extends StatelessWidget {
  final int delayAmount = 500;
  final bgImage = 'assets/flare/pickrr.flr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
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
          ],
        ),
        body: Stack(
          children: <Widget>[
            new FlareActor(bgImage,
                alignment: Alignment.center, fit: BoxFit.cover),
            Positioned(
              top: 80,
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
                                'Want to be your own boss?',
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
                                  'The Pickrr Rider Portal helps you earn smarter with realtime information on orders.',
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
                                _settingModalBottomSheet(context);
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 0, top: 12),
                  child: ListTile(
                    leading: new Text('Select Your Plan',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: 17,
                            color: AppColor.primaryText,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                Card(
                  elevation: 0,
                  child: new ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 2, right: 3),
                        child: SvgPicture.asset('assets/svg/personal.svg',
                            height: 37, semanticsLabel: 'search icon'),
                      ),
                      title: new Text('Personal account',
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      subtitle: Text('Manage your bike and earnings',
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.grey[400],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/DriverApplication');
                      }),
                ),
                Card(
                  elevation: 0,
                  child: new ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 2, right: 3),
                        child: SvgPicture.asset('assets/svg/business.svg',
                            height: 37, semanticsLabel: 'search icon'),
                      ),
                      title: new Text('Business account',
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      subtitle: Text('Register and manage all your bikes.',
                          style: TextStyle(
                              fontFamily: 'Ubuntu',
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.grey[400],
                      ),
                      onTap: () => {}),
                ),
              ],
            ),
          );
        });
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
