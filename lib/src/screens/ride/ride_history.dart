import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/ride/orders/bloc.dart';
import 'package:pickrr_app/src/models/ride.dart';
import 'package:pickrr_app/src/widgets/arguments.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/widgets/ride_history_details.dart';
import 'package:pickrr_app/src/widgets/ride_status.dart';

class RideHistory extends StatefulWidget {
  @override
  _RideHistoryState createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  RideOrdersBloc _rideOrdersBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _rideOrdersBloc = BlocProvider.of<RideOrdersBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _rideOrdersBloc.add(OrdersReset());
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title: Text(
              'Order History',
              style: TextStyle(
                  fontFamily: "Ubuntu",
                  fontSize: 17.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.black))),
        body: SafeArea(
          child:
              // ignore: missing_return
              BlocBuilder<RideOrdersBloc, RideOrdersState>(builder: (_, state) {
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
                        return IndividualRideCard(ride);
                      },
                      childCount: state.hasReachedMax
                          ? state.rides.length
                          : state.rides.length + 1,
                    ))
                  ]);
            }
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _rideOrdersBloc.add(OrdersReset());
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _rideOrdersBloc.add(OrdersFetched());
    }
  }
}
