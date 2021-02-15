import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/models/wallet.dart';
import 'package:pickrr_app/src/services/repositories/wallet.dart';
import 'package:pickrr_app/src/widgets/input.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';
import 'package:pickrr_app/src/helpers/utility.dart';

class BalanceWithdrawal extends StatefulWidget {
  final VoidCallback onFinishProcess;

  BalanceWithdrawal({this.onFinishProcess});

  @override
  _BalanceWithdrawalState createState() => _BalanceWithdrawalState();
}

class _BalanceWithdrawalState extends State<BalanceWithdrawal> {
  TextEditingController _amountController;
  WalletRepository _walletRepository;
  Bank selectedBank;
  TextEditingController _accountNameController;
  TextEditingController _accountNumberController;
  List<Bank> _banks = [];
  static const _locale = 'en';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  @override
  void initState() {
    _amountController = new TextEditingController();
    _accountNumberController = new TextEditingController();
    _accountNameController = new TextEditingController();
    _walletRepository = WalletRepository();
    _getBankNames();
    super.initState();
  }

  _getBankNames() async {
    var rawBanks = await _walletRepository.getBanks();
    rawBanks.forEach((rawDetail) {
      Bank bank = Bank.fromMap(rawDetail);
      _banks.add(bank);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Balance Withdrawal',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Ubuntu',
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Stack(children: <Widget>[
                      SafeArea(
                          child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: <Widget>[
                            SizedBox(height: 10),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                  'Please NOTE: There is a NGN 50 charge for every withdrawal.',
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                      fontSize: 13)),
                            ),
                            SizedBox(height: 5),
                            Container(
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                color: Colors.grey[200],
                                child: InputField(
                                  onChanged: (string) {
                                    string =
                                        '${_formatNumber(string.replaceAll(',', ''))}';
                                    _amountController.value = TextEditingValue(
                                      text: string,
                                      selection: TextSelection.collapsed(
                                          offset: string.length),
                                    );
                                  },
                                  inputFormatters: [
                                    BlacklistingTextInputFormatter(
                                        new RegExp('[\\-|\\ ]'))
                                  ],
                                  inputType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputController: _amountController,
                                  hintText: 'Enter amount',
                                  onPressed: () {
                                    setState(() {
                                      _amountController.clear();
                                    });
                                  },
                                )),
                            Container(
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                color: Colors.grey[200],
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        iconEnabledColor: AppColor.grey,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                        underline: Text(''),
                                        hint: Text('Select Bank',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily: 'Roboto',
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400)),
                                        isExpanded: true,
                                        iconSize: 23,
                                        value: selectedBank == null
                                            ? null
                                            : selectedBank.bankName,
                                        items: _banks.map((Bank value) {
                                          return new DropdownMenuItem<String>(
                                            value: value.bankName,
                                            child: new Text(value.bankName,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                  inherit: false,
                                                )),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          final int bankIndex =
                                              _banks.indexWhere((element) =>
                                                  element.bankName == value);
                                          if (bankIndex > -1) {
                                            setState(() {
                                              selectedBank = _banks[bankIndex];
                                            });
                                          }
                                        }))),
                            Container(
                                alignment: Alignment.center,
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                color: Colors.grey[200],
                                child: InputField(
                                  inputController: _accountNameController,
                                  hintText: 'Account Name',
                                  onPressed: () {
                                    setState(() {
                                      _accountNameController.clear();
                                    });
                                  },
                                )),
                            Container(
                                alignment: Alignment.center,
                                height: 47,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                color: Colors.grey[200],
                                child: InputField(
                                  inputController: _accountNumberController,
                                  hintText: 'Account Number',
                                  onPressed: () {
                                    setState(() {
                                      _accountNumberController.clear();
                                    });
                                  },
                                ))
                          ])),
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 46,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: FlatButton(
                        splashColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        onPressed: () => _submitWithdrawalRequest(),
                        color: AppColor.primaryText,
                        child: Text("Submit Request",
                            style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                                height: 1.4)),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ])));
  }

  _isFormValid() =>
      _amountController.text != null &&
      _amountController.text.isNotEmpty &&
      _accountNumberController.text != null &&
      _accountNumberController.text.isNotEmpty &&
      _accountNameController.text != null &&
      _accountNameController.text.isNotEmpty &&
      selectedBank != null;

  _submitWithdrawalRequest() async {
    if (!_isFormValid()) {
      AlertBar.dialog(context, 'Please fill in all fields', Colors.red,
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ),
          duration: 5);
      return;
    }

    AlertBar.dialog(context, 'Requesting withdrawal...', AppColor.primaryText,
        showProgressIndicator: true, duration: null);

    try {
      Map<String, dynamic> formDetails = {
        'amount': _amountController.text,
        'account_number': _accountNumberController.text,
        'account_name': _accountNameController.text,
        'bank_name': selectedBank.bankName,
        'bank_code': selectedBank.bankCode,
      };

      await _walletRepository
          .withdrawFromBank(new FormData.fromMap(formDetails));
      Navigator.pop(context);
      Navigator.pop(context);
      widget.onFinishProcess();
      AlertBar.dialog(context, 'Withdrawal Successful.', Colors.green,
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          duration: 10);
    } catch (err) {
      debugLog(err);
      Navigator.pop(context);
      AlertBar.dialog(context, err.message, Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
