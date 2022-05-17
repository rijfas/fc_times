import 'package:flutter/material.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:fc_times/constants.dart';

void showCustomDialog(BuildContext context, String title) {
  Alert(
      style: AlertStyle(
          alertBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          isCloseButton: false,
          backgroundColor: kCardColorDark,
          titleStyle: TextStyle(color: Colors.white),
          descStyle: TextStyle(color: Colors.white)),
      context: context,
      title: title,
      buttons: [
        DialogButton(
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.pop(context),
          color: kPrimaryColor,
        )
      ]).show();
}

void showCustomLoading(BuildContext context) {
  Alert(
      style: AlertStyle(
        isOverlayTapDismiss: false,
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        isCloseButton: false,
        backgroundColor: kCardColorDark,
        titleStyle: TextStyle(color: Colors.white),
        descStyle: TextStyle(color: Colors.white),
      ),
      context: context,
      title: 'Loading',
      content: SpinKitFadingCircle(
        color: kPrimaryColor,
        size: kLoadingIconSize,
      ),
      buttons: []).show();
}

void showCustomError(BuildContext context, String title) {
  Alert(
      style: AlertStyle(
          alertBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          isCloseButton: false,
          backgroundColor: kCardColorDark,
          titleStyle: TextStyle(color: Colors.white),
          descStyle: TextStyle(color: Colors.white)),
      context: context,
      title: title,
      buttons: [
        DialogButton(
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.pop(context),
          color: kPrimaryColor,
        )
      ]).show();
}

void closeLastDialog(BuildContext context) {
  Navigator.pop(context);
}

void showCustomWarning({
  @required BuildContext context,
  @required Function onOkPressed,
  @required Function onCancelPressed,
  @required String title,
  @required String content,
}) {
  Alert(
      style: AlertStyle(
        isOverlayTapDismiss: false,
        alertBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        isCloseButton: false,
        backgroundColor: kCardColorDark,
        titleStyle: TextStyle(color: Colors.white),
        descStyle: TextStyle(color: Colors.white),
      ),
      context: context,
      title: title,
      content: Text(
        content,
        style: TextStyle(color: Colors.red, fontSize: 15.0),
      ),
      buttons: [
        DialogButton(
            color: kPrimaryColor,
            child: Text(
              'Ok',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            onPressed: onOkPressed),
        DialogButton(
            color: kPrimaryColor,
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            onPressed: onCancelPressed),
      ]).show();
}
