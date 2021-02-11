import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/services/repositories/ride.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';
import 'package:pickrr_app/src/widgets/image.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RideRatingDialog extends StatefulWidget {
  final RideArguments arguments;

  RideRatingDialog(this.arguments);

  @override
  _RideRatingDialogState createState() => _RideRatingDialogState();
}

class _RideRatingDialogState extends State<RideRatingDialog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _rating;
  String _selectedReview;
  List<String> _reviews = [
    'Driver did not deliver on time.',
    'Driver is very rude.',
    'Excellent ride!',
    'Driver is unprofessional.'
  ];
  RideRepository _rideRepository = RideRepository();

  @override
  void initState() {
    _rating = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Rate this ride!',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w600,
                  fontSize: 20)),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                  child: Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(color: Colors.white),
                      child:
                          widget.arguments.ride.rider.details.profileImageUrl !=
                                      null ||
                                  widget.arguments.ride.rider.details
                                      .profileImageUrl.isNotEmpty
                              ? CustomImage(
                                  imageUrl:
                                      '${widget.arguments.ride.rider.details.profileImageUrl}',
                                )
                              : Image.asset('assets/images/placeholder.jpg',
                                  width: double.infinity,
                                  height: double.infinity))),
              Text(widget.arguments.ride.rider.details.fullname,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
              SizedBox(height: 20),
              SmoothStarRating(
                allowHalfRating: true,
                onRatingChanged: (value) {
                  setState(() {
                    _rating = double.parse(value.toStringAsFixed(2));
                  });
                },
                starCount: 5,
                rating: _rating,
                size: 35.0,
                color: Colors.amber,
                borderColor: Colors.grey[400],
                spacing: 5.0,
              ),
              Expanded(child: SizedBox()),
              DropdownButton(
                hint: Text(
                  'Select a review here...',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontFamily: 'Ubuntu'),
                ), // Not necessary for Option 1
                value: _selectedReview,
                onChanged: (newValue) {
                  setState(() {
                    _selectedReview = newValue;
                  });
                },
                items: _reviews.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: 'Ubuntu')),
                    value: location,
                  );
                }).toList(),
              ),
              GestureDetector(
                onTap: () => _processRating(),
                child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    color: AppColor.primaryText,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 13),
                    child: Center(
                        child: Text('Submit feedback',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'Ubuntu')))),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 43,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Center(
                        child: Text('Skip feedback',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontFamily: 'Ubuntu')))),
              ),
            ],
          ),
        ));
  }

  _processRating() async {
    if (_rating == null || _rating == 0) {
      return;
    }

    AlertBar.dialog(context, 'Submitting request...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      Map<String, dynamic> formDetails = {
        'review': _selectedReview,
        'star': _rating,
      };

      var response = await _rideRepository.submitRideRating(
          new FormData.fromMap(formDetails), widget.arguments.ride.id);
      Navigator.pop(context);
      Review review = Review.fromMap(response);
      AlertBar.dialog(context, 'Rating submitted!', Colors.green,
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          duration: 10);
      widget.arguments.ride.review = review;
      Future.delayed(new Duration(seconds: 2), () {
        Navigator.popUntil(
            context, (Route<dynamic> route) => route is PageRoute);
        Navigator.popAndPushNamed(context, '/RideDetails',
            arguments: RideArguments(widget.arguments.ride));
      });
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }
}
