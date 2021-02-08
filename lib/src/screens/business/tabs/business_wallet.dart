import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/blocs/business/transaction/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/services/repositories/business.dart';
import 'package:pickrr_app/src/widgets/nav_drawer.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';

class BusinessWallet extends StatefulWidget {
  BusinessWallet({Key key}) : super(key: key);

  @override
  _BusinessWalletState createState() => _BusinessWalletState();
}

class _BusinessWalletState extends State<BusinessWallet> {
  final BusinessRepository _businessRepository = BusinessRepository();
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  BusinessTransactionBloc _historyBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _historyBloc = BlocProvider.of<BusinessTransactionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (_, state) {
      if (state is NonLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => Navigator.pushReplacementNamed(context, '/'));
      }
      if (state.props.isEmpty) {
        return Container();
      }
      User user = state.props[0];

      return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Text('My Wallet',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Ubuntu')),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              Row(
                children: [
                  FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none ||
                            snapshot.hasData == null ||
                            !snapshot.hasData) {
                          return SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            ),
                          );
                        }
                        final businessDetails = snapshot.data;
                        return businessDetails.balance < 0
                            ? RaisedButton(
                                elevation: 8,
                                onPressed: () {},
                                color: AppColor.primaryText,
                                child: Text('Clear Debt',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'Ubuntu')))
                            : RaisedButton(
                                elevation: 8,
                                onPressed: () {},
                                color: AppColor.primaryText,
                                child: Text('Withdraw',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'Ubuntu')));
                      },
                      future: _businessRepository
                          .getBusinessFromStorage(user.businessId)),
                  SizedBox(width: 20)
                ],
              ),
            ],
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu_rounded, color: Colors.black),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),
          drawer: BusinessNavDrawer(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                new Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 10, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.none ||
                                  snapshot.hasData == null ||
                                  !snapshot.hasData) {
                                return SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                  ),
                                );
                              }
                              final businessDetails = snapshot.data;
                              return Center(
                                child: Column(
                                  children: [
                                    Text('Balance',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                businessDetails.balance < 0
                                                    ? Colors.red
                                                    : Colors.green)),
                                    Text(
                                        '\u20A6 ${businessDetails.balanceHumanized}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                  ],
                                ),
                              );
                            },
                            future: _businessRepository
                                .getBusinessFromStorage(user.businessId)),
                        SizedBox(height: 15),
                        Text(
                          'Transactions',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Ubuntu'),
                        )
                      ],
                    )),
                BlocBuilder<BusinessTransactionBloc, BusinessTransactionState>(
                    // ignore: missing_return
                    builder: (_, state) {
                  if (state.isFailure) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text("No transaction!"),
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
                        padding: EdgeInsets.all(8.0),
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: state.hasReachedMax
                            ? state.histories.length
                            : state.histories.length + 1,
                        physics: const BouncingScrollPhysics(),
                        dragStartBehavior: DragStartBehavior.down,
                        itemBuilder: (_, index) {
                          if (index >= state.histories.length) {
                            return PreLoader();
                          }
                          History history = state.histories[index];
                          return historyDetails(history);
                        });
                  }
                })
              ],
            ),
          ));
    });
  }

  historyDetails(History history) => Card(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0, left: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(),
                        Text("\u20A6 ${history.balance}",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(getFullTime(history.createdAt),
                            style: TextStyle(
                                fontSize: 13.0, fontWeight: FontWeight.normal)),
                        history.type == 'DEDUCTION'
                            ? Text("- \u20A6 ${history.amount}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.red[500],
                                ))
                            : Text("+ \u20A6 ${history.amount}",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.green[500],
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
      );

  @override
  void dispose() {
    _historyBloc.add(BusinessTransactionReset());
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _historyBloc.add(BusinessTransactionFetched());
    }
  }
}
