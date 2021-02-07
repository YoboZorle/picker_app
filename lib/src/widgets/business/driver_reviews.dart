import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/driver/rated_rides/bloc.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/widgets/image.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DriverReviews extends StatefulWidget {
  final int riderId;

  DriverReviews({Key key, this.riderId}) : super(key: key);

  @override
  _DriverReviewsState createState() => _DriverReviewsState();
}

class _DriverReviewsState extends State<DriverReviews> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  RatedRidesBloc _ratedRidesBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _ratedRidesBloc = BlocProvider.of<RatedRidesBloc>(context);
    _ratedRidesBloc.add(RatedRidesFetched(widget.riderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<RatedRidesBloc, RatedRidesState>(
            // ignore: missing_return
            builder: (_, state) {
          if (state.isFailure) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text("No reviews!"),
                  alignment: Alignment.center,
                ),
              ],
            );
          }
          if (state.isInitial || !state.isSuccess && state.isLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                ),
              ],
            );
          }
          if (state.isSuccess) {
            return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: state.hasReachedMax
                  ? state.rides.length
                  : state.rides.length + 1,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                if (index >= state.rides.length) {
                  return PreLoader();
                }
                Ride ride = state.rides[index];
                return Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                            child: Container(
                              height: 35.0,
                              width: 35.0,
                              child: !ride.user.noProfileImage
                                  ? CustomImage(
                                imageUrl:
                                '${ride.user.profileImageUrl}',
                              )
                                  : Image.asset('assets/images/placeholder.jpg',
                                  width: double.infinity, height: double.infinity),
                            )),
                      ],
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(ride.user.fullname,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        SmoothStarRating(
                          allowHalfRating: true,
                          onRatingChanged: (value) {
                          },
                          starCount: 5,
                          rating: ride.review.star,
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
                        Text(ride.review.review,
                            style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: "Ubuntu",
                                height: 1.3,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                        Text(getChatTime(ride.review.createdAt),
                            style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: "Ubuntu",
                                color: Colors.grey,
                                height: 1.3,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }));
  }

  @override
  void dispose() {
    _ratedRidesBloc.add(RatedRidesReset());
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _ratedRidesBloc.add(RatedRidesFetched(widget.riderId));
    }
  }
}
