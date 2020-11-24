import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/utils/transitionAppbar/transition_appbar.dart';

class DriverWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    cryptoPortfolioItem(String img, String name, double amount, String rate,
            String percentage) =>
        Card(
          elevation: 0,
          child: InkWell(
            onTap: () => print("tapped"),
            child: Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 15.0),
                      // child: Icon(icon, color: Colors.grey),
                      child: CircularProfileAvatar(
                        img,
                        radius: 25,
                        backgroundColor: Colors.grey[200],
                        // sets initials text, set your own style, default Text('')
                        borderColor: Colors
                            .brown, // sets border color, default Colors.white
                        elevation:
                            0.0, // sets elevation (shadow of the profile picture), default value is 0.0
                        cacheImage:
                            true, // allow widget to cache image against provided url
                        onTap: () {
                          print('yea');
                        }, // sets on tap
                        showInitialTextAbovePicture:
                            false, // setting it true will show initials text above profile picture, default false
                      )),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                  fontFamily: "Ubuntu",
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text("\u20A6$amount",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("$rate",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal)),
                            Text("+ \u20A6$percentage",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red[500],
                                ))
                          ],
                        )
                      ],
                    ),
                    flex: 3,
                  ),
                ],
              ),
            ),
          ),
        );
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            TransitionAppBar(
              extent: 100,
              avatar: Text("Total balance",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Ubuntu',
                    fontSize: 15,
                  )),
              title: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Row(children: <Widget>[
                  Text("\u20A6500.00",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Ubuntu',
                        fontSize: 27,
                      )),
                  Expanded(child: SizedBox()),
                  RaisedButton(
                    elevation: 15,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, right: 8, left: 8),
                      child: Text('Withdraw',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontFamily: "Ubuntu",
                              fontWeight: FontWeight.w600)),
                    ),
                    color: AppColors.primaryText,
                    textColor: AppColors.primaryText,
                    onPressed: () {},
                  ),
                ]),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10),
                  cryptoPortfolioItem(
                      'https://www.bellanaija.com/wp-content/uploads/2016/04/seunlogan_topnigerianmodel_bellanaija_2016_01.jpg',
                      "Uche Chijioke",
                      410.80,
                      'Oct 31, 2020',
                      "82.19(92%)"),
                  cryptoPortfolioItem(
                      'https://i.pinimg.com/originals/1d/70/5a/1d705a159905b3e2d7af4b27299be216.jpg',
                      "Eyin Nwig",
                      1089.86,
                      'Nov 1, 2020',
                      "13.10(2.3%)"),
                  cryptoPortfolioItem(
                      'https://images.unsplash.com/photo-1586171984069-1dbce3573a10?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                      "Amarachi Chris",
                      22998.13,
                      '3 Nov, 2020',
                      "120(3.6%)"),
                  cryptoPortfolioItem(
                      'https://asset1.modelmanagement.com/mm-eyJ0Ijp7InIiOiIzMjAi/fSwiaWQiOiJpNjYyMTM5/MyIsImYiOiJqcGcifQ;;.jpg',
                      "Cindy Stevie",
                      410.80,
                      '3 Nov, 2020',
                      "82.19(92%)"),
                  cryptoPortfolioItem(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTOjDgqRFB7Aqe20oFvMqdH9SLR8_GyumBxZw&usqp=CAU',
                      "Enel Amadi",
                      1089.86,
                      '4 Nov, 2020',
                      "13.10(2.3%)"),
                  cryptoPortfolioItem(
                      'https://modelstalk.ng/wp-content/uploads/2019/05/IMG-20190509-WA0009.jpg',
                      "Clara Bassey",
                      22998.13,
                      '5 Nov, 2020',
                      "120(3.6%)"),
                  cryptoPortfolioItem(
                      'https://shutterfinger.typepad.com/.a/6a00e551a6244a8833019affd0eb14970d-pi',
                      "Dave Smith",
                      410.80,
                      '6 Nov, 2020',
                      "82.19(92%)"),
                  cryptoPortfolioItem(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSPiXY1VKY8ZFJjPPVRCR6J13DMji3czuNdFQ&usqp=CAU',
                      "Jack Bara",
                      1089.86,
                      '6 Nov, 2020',
                      "13.10(2.3%)"),
                  cryptoPortfolioItem(
                      'https://sbly-web-prod-shareably.netdna-ssl.com/wp-content/uploads/2018/11/26204648/nigerian13.jpg',
                      "Cassie Tassie",
                      22998.13,
                      '6 Nov, 2020',
                      "120(3.6%)"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
