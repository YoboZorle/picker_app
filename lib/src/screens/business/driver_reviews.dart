import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DriverReviews extends StatefulWidget {
  final String title;

  DriverReviews({Key key, this.title}) : super(key: key);

  @override
  _DriverReviewsState createState() => _DriverReviewsState();
}

class _DriverReviewsState extends State<DriverReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            child: ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                  "https://bloximages.chicago2.vip.townnews.com/stlamerican.com/content/tncms/assets/v3/editorial/1/cb/1cb65068-c76d-11e8-8686-7f40e5fbe1d0/5bb5605309dba.image.jpg?resize=400%2C422")))),
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Yobo Zorle',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Ubuntu",
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  SmoothStarRating(
                    allowHalfRating: true,
                    onRatingChanged: (value) {
                      // setState(() {
                      //   rating =4value;
                      // });
                    },
                    starCount: 5,
                    rating: 3,
                    size: 11.0,
                    color: Colors.amber,
                    borderColor: Colors.grey[400],
                    spacing: 0,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amadi is a cool guy and his delivery was swift.',
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: "Ubuntu",
                          height: 1.3,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)
                  ),
                  Text(
                    '2days ago',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Ubuntu",
                          color: Colors.grey,
                          height: 1.3,
                          fontWeight: FontWeight.w400)
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
