import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:pickrr_app/src/blocs/authentication/bloc.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/blocs/driver/driver_history/bloc.dart';
import 'package:pickrr_app/src/helpers/payment.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/models/driver.dart';
import 'package:pickrr_app/src/models/user.dart';
import 'package:pickrr_app/src/models/wallet.dart';
import 'package:pickrr_app/src/screens/business/withdrawal.dart';
import 'package:pickrr_app/src/services/repositories/driver.dart';
import 'package:pickrr_app/src/services/repositories/wallet.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/widgets/preloader.dart';

class DriverWallet extends StatefulWidget {
  DriverWallet({Key key}) : super(key: key);

  @override
  _DriverWalletState createState() => _DriverWalletState();
}

class _DriverWalletState extends State<DriverWallet> {
  final DriverRepository _driverRepository = DriverRepository();
  WalletRepository _walletRepository = WalletRepository();
  final _scrollController = ScrollController();
  final currencyFormatter =
      NumberFormat.currency(locale: 'en_US', symbol: '\u20a6');
  final _scrollThreshold = 200.0;
  DriverHistoryBloc _historyBloc;
  bool deactivateActionBtn = false;

  @override
  void initState() {
    super.initState();
    PaystackPlugin.initialize(publicKey: AppData.paystackPublicKey);
    _scrollController.addListener(_onScroll);
    _historyBloc = BlocProvider.of<DriverHistoryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          _historyBloc.add(DriverHistoryReset());
          return true;
        },
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildListDelegate([
                  FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none ||
                            snapshot.hasData == null ||
                            !snapshot.hasData) {
                          return Container();
                        }
                        final driverDetails = snapshot.data;
                        final Wallet wallet = Wallet.fromMap(driverDetails);
                        return BlocBuilder<AuthenticationBloc,
                            AuthenticationState>(builder: (_, state) {
                          if (state is NonLoggedIn) {
                            WidgetsBinding.instance.addPostFrameCallback((_) =>
                                Navigator.pushReplacementNamed(context, '/'));
                          }
                          if (state.props.isEmpty) {
                            return Container();
                          }
                          User user = state.props[0];

                          return Column(
                            children: [
                              wallet.balance < 0
                                  ? Container(
                                      child: RaisedButton(
                                          elevation: 8,
                                          onPressed: deactivateActionBtn
                                              ? null
                                              : () {
                                                  chargeCard(wallet.debts, user);
                                                },
                                          color: AppColor.primaryText,
                                          child: Text('Clear Debt',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  fontFamily: 'Ubuntu'))),
                                      margin:
                                          EdgeInsets.only(right: 15, top: 10),
                                      alignment: Alignment.topRight,
                                    )
                                  : Container(
                                      margin:
                                          EdgeInsets.only(right: 15, top: 10),
                                      alignment: Alignment.topRight,
                                      child: RaisedButton(
                                          elevation: 8,
                                          onPressed: () {
                                            showWithdraw();
                                          },
                                          color: AppColor.primaryText,
                                          child: Text('Withdraw',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  fontFamily: 'Ubuntu'))),
                                    ),
                              SizedBox(height: 10),
                              Center(
                                child: Column(
                                  children: [
                                    Text('Balance',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: wallet.balance < 0
                                                ? Colors.red
                                                : Colors.green)),
                                    Text('\u20A6 ${wallet.balanceHumanized}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                      },
                      future: _driverRepository.getDriverWalletDetails()),
                ])),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 10),
                      BlocBuilder<DriverHistoryBloc, DriverHistoryState>(
                          // ignore: missing_return
                          builder: (_, state) {
                        if (state.isFailure) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text("No history!"),
                                alignment: Alignment.center,
                              ),
                            ],
                          );
                        }
                        if (state.isInitial ||
                            !state.isSuccess && state.isLoading) {
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
                )
              ],
            ),
          ),
        ));
  }

  historyDetails(History history) => Card(
        elevation: 0,
        child: Container(
          padding:
              EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0, left: 15.0),
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
    _historyBloc.add(DriverHistoryReset());
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _historyBloc.add(DriverHistoryFetched());
    }
  }

  void showWithdraw() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext bc) {
          return SafeArea(
            child: BalanceWithdrawalDriver(onFinishProcess: _onFinishProcess),
          );
        });
  }

  chargeCard(double amount, User user) async {
    setState(() {
      deactivateActionBtn = true;
    });
    var result = await _walletRepository.initiateTransaction(
        new FormData.fromMap(<String, dynamic>{'amount': amount.round()}));
    setState(() {
      deactivateActionBtn = false;
    });
    final int amountInKobo = amount.round() * 100;

    Charge charge = Charge()
      ..amount = amountInKobo
      ..accessCode = result["access_code"]
      ..email = user.email;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.selectable,
      charge: charge,
    );
    if (response.status == true) {
      await _submitPaymentRequest(response.reference);
    } else {
      _showErrorDialog();
    }
  }

  _submitPaymentRequest(String transactionReference) async {
    AlertBar.dialog(
        context, 'Processing payment. Please wait...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      Map<String, dynamic> formDetails = {
        'transaction_id': transactionReference
      };

      await _walletRepository
          .settleDriverDebt(new FormData.fromMap(formDetails));
      Navigator.pop(context);
      setState(() {});
      _showSuccessDialog();
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return successDialog(context);
      },
    );
  }

  void _onFinishProcess() {
    setState(() {});
  }
}
