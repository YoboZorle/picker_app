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
          // return Container(
          //   color: Colors.white,
          //   margin: EdgeInsets.only(bottom: 15),
          //   padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //               allRequests()[index].rideDistance +
          //                   '/' +
          //                   allRequests()[index].rideTime,
          //               style: TextStyle(
          //                   color: Colors.grey,
          //                   fontSize: 13,
          //                   fontFamily: 'Ubuntu')),
          //           Text(allRequests()[index].date,
          //               style: TextStyle(
          //                   color: Colors.grey,
          //                   fontSize: 13,
          //                   fontFamily: 'Ubuntu')),
          //         ],
          //       ),
          //       SizedBox(height: 10),
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Container(
          //             width: 40,
          //             margin: EdgeInsets.only(right: 8),
          //             child: Text("From: ",
          //                 style: TextStyle(
          //                     fontSize: 13,
          //                     color: Colors.grey,
          //                     fontFamily: 'Ubuntu',
          //                     fontWeight: FontWeight.w400)),
          //           ),
          //           Flexible(
          //             child: Text(allRequests()[index].fromAddress,
          //                 style: TextStyle(
          //                     fontSize: 14,
          //                     color: Colors.black,
          //                     fontFamily: 'Ubuntu',
          //                     fontWeight: FontWeight.w400)),
          //           ),
          //         ],
          //       ),
          //       SizedBox(height: 8),
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Container(
          //             width: 40,
          //             margin: EdgeInsets.only(right: 8),
          //             child: Text("To: ",
          //                 style: TextStyle(
          //                     fontSize: 13,
          //                     color: Colors.grey,
          //                     fontFamily: 'Ubuntu',
          //                     fontWeight: FontWeight.w400)),
          //           ),
          //           Flexible(
          //             child: Text(allRequests()[index].toAddress,
          //                 style: TextStyle(
          //                     fontSize: 14,
          //                     color: Colors.black,
          //                     fontFamily: 'Ubuntu',
          //                     fontWeight: FontWeight.w400)),
          //           ),
          //         ],
          //       ),
          //       Container(
          //           width: MediaQuery.of(context).size.width,
          //           height: 0.7,
          //           margin: EdgeInsets.only(top: 18),
          //           color: Colors.grey[200]),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Text(allRequests()[index].rideAmount,
          //               style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 14,
          //                   fontFamily: 'Ubuntu')),
          //           InkWell(
          //             child: Container(
          //               height: 35,
          //               padding: EdgeInsets.only(left: 30),
          //               margin: EdgeInsets.symmetric(vertical: 8),
          //               child: Row(
          //                 children: [
          //                   Text("ASSIGN DRIVER",
          //                       style: TextStyle(
          //                           fontSize: 13,
          //                           color: AppColor.primaryText,
          //                           fontFamily: 'Ubuntu',
          //                           fontWeight: FontWeight.w500)),
          //                   SizedBox(width: 5),
          //                   Icon(Icons.arrow_forward_ios_outlined,
          //                       color: AppColor.primaryText, size: 16)
          //                 ],
          //               ),
          //             ),
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute<Null>(
          //                     builder: (BuildContext context) {
          //                       return AssignDriver();
          //                     },
          //                     fullscreenDialog: true,
          //                   ));
          //             },
          //             splashColor: Colors.grey[300],
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // );

          return ListTile(
            leading: Container(
                width: 40.0,
                height: 40.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                            "https://bloximages.chicago2.vip.townnews.com/stlamerican.com/content/tncms/assets/v3/editorial/1/cb/1cb65068-c76d-11e8-8686-7f40e5fbe1d0/5bb5605309dba.image.jpg?resize=400%2C422")))),
            title: Text('Yobo Zorle'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'time here',
                  style: TextStyle(),
                ),
                Text(
                  'time again',
                  style: TextStyle(),
                ),
              ],
            ),
            trailing: SmoothStarRating(
              allowHalfRating: true,
              onRatingChanged: (value) {
                // setState(() {
                //   rating =4value;
                // });
              },
              starCount: 5,
              rating: 3,
              size: 13.0,
              color: Colors.amber,
              borderColor: Colors.grey[400],
              spacing: 0,
            ),
          );
        },
      ),
    );
  }
}
