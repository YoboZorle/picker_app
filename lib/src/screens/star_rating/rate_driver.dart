import 'package:flutter/material.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RateDriver extends StatefulWidget {
  RatingBarWidget createState() => RatingBarWidget();
}

class RatingBarWidget extends State {
  double rating = 0;

  List<String> _locations = [
    'Driver did not deliver on time.',
    'Driver is very rude.',
    'Excellent ride!',
    'Driver is unprofessional.'
  ];
  String _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Ride Complete!',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w600,
                  fontSize: 20)),
        ),
        body: Container(width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Please rate your last ride',
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w400,
                      fontSize: 14)),
              Container(
                  width: 70.0,
                  height: 70.0,
                  margin: EdgeInsets.only( top: 20, bottom: 18),
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://blog.bolt.eu/wp-content/uploads/2020/06/1200x628_Oaksure-Financial-Services-insurance-covers-Bolt-passengers-and-drivers-on-all-rides.jpg")))),

              Text('George Adowei',
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
                    rating = value;
                  });
                },
                starCount: 5,
                rating: rating,
                size: 35.0,
                color: Colors.amber,
                borderColor: Colors.grey[300],
                spacing: 5.0,
              ),
              SizedBox(height: 10),
              Text('Rating = ' + '$rating',  style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                  fontSize: 12)),
              Expanded(child: SizedBox()),
              DropdownButton(
                hint: Text(
                  'Leave your feedback',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontFamily: 'Ubuntu'),
                ), // Not necessary for Option 1
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                },
                items: _locations.map((location) {
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
                onTap: (){

                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.primaryText,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 13),
                  child: Center(child: Text('Submit feedback',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontFamily: 'Ubuntu')))
                ),
              ),

              GestureDetector(
                onTap: (){
Navigator.pop(context);
                },
                child: Container(
                    height: 43,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                    child: Center(child: Text('Skip feedback',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: 'Ubuntu')))
                ),
              ),
            ],
          ),
        ));
  }
}
