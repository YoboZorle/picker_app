import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/business/driver_history/bloc.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';
import 'package:pickrr_app/src/widgets/ride_status.dart';

class DriverRideHistory extends StatefulWidget {
  final int riderId;

  DriverRideHistory({this.riderId});

  @override
  _DriverRideHistoryState createState() => _DriverRideHistoryState();
}

class _DriverRideHistoryState extends State<DriverRideHistory> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  BusinessRideHistoryBloc _businessRideHistoryBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _businessRideHistoryBloc =
        BlocProvider.of<BusinessRideHistoryBloc>(context);
    _businessRideHistoryBloc.add(BusinessRideHistoryFetched(widget.riderId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessRideHistoryBloc, BusinessRideHistoryState>(
        // ignore: missing_return
        builder: (_, state) {
      if (state.isFailure) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("No order history!"),
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
        return CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index >= state.rides.length) {
                    return PreLoader();
                  }
                  Ride ride = state.rides[index];
                  return InkWell(
                    onTap: () => Navigator.pushNamed(context, '/RideDetails',
                        arguments: RideArguments(ride)),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: ListTile(
                              title: Text(
                                ride.deliveryLocation.address,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getFullTime(ride.createdAt),
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Ubuntu",
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        height: 1.6),
                                  ),
                                  RideStatusText(ride.status)
                                ],
                              ),
                              contentPadding: EdgeInsets.all(0),
                              dense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: state.hasReachedMax
                    ? state.rides.length
                    : state.rides.length + 1,
              ))
            ]);
      }
    });
  }

  @override
  void dispose() {
    _businessRideHistoryBloc.add(BusinessRideHistoryReset());
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _businessRideHistoryBloc.add(BusinessRideHistoryFetched(widget.riderId));
    }
  }
}
