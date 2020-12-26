import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';
import 'package:pickrr_app/src/helpers/constants.dart';
import 'package:pickrr_app/src/helpers/utility.dart';
import 'package:pickrr_app/src/utils/alert_bar.dart';


class OnlinePayment {
  final BuildContext context;
  final String amount;
  final String userPhone;
  final String userEmail;
  final String userName;
  final Function onCompletePayment;

  ///Random 9 alpha-numeric character for validating transaction
  final String transactionRef = getRandomString(9);

  OnlinePayment({this.context, this.amount, this.userPhone, this.userEmail, this.userName, this.onCompletePayment});

  Flutterwave _paymentDialog() {
    return Flutterwave.forUIPayment(
        context: context,
        encryptionKey: AppData.flutterWaveEncryptionKey,
        publicKey: AppData.flutterWavePublicKey,
        currency: AppData.currency,
        amount: amount,
        email: userEmail,
        fullName: userName,
        txRef: transactionRef,
        isDebugMode: true,
        phoneNumber: userPhone,
        acceptCardPayment: true,
        acceptUSSDPayment: true,
        acceptAccountPayment: true,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: false,
        acceptUgandaPayment: false,
        acceptZambiaPayment: false);
  }

  processPayment() async {
    final Flutterwave flutterwave = _paymentDialog();

    try {
      final ChargeResponse response = await flutterwave.initializeForUiPayments();
      if (response == null) {
        debugLog('User canceled transaction');
      } else {
        final isSuccessful = paymentValidation(response, transactionRef);
        if (isSuccessful) {
          return onCompletePayment(transactionRef);
        } else {
          Navigator.pop(context);
          AlertBar.dialog(context,
              response.message, Colors.red,
              icon: Icon(Icons.error), duration: 5);
          debugLog(response.message);
          debugLog(response.data.processorResponse);
        }
      }
    } catch (error, _) {
      Navigator.pop(context);
      AlertBar.dialog(context,
          'Payment could not be processed. Please try again.', Colors.red,
          icon: Icon(Icons.error), duration: 5);
    }
  }

  bool paymentValidation(final ChargeResponse response, String transactionRef) {
    return response != null && response.data.txRef == transactionRef;
  }
}