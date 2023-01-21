import 'package:flutter/material.dart';
import '../../constatnts/colors.dart';

extension textStyle on Text {
  Text largeHeadline(BuildContext context,
      {Color textColor = AppColors.onPrimary, fontSize = largeHeadLineSize}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(
          fontFamily: appNameFontFamily,
          color: textColor,
          fontSize: MediaQuery.of(context).textScaleFactor * fontSize),
    );
  }

  Text largeHeadline1(BuildContext context,
      {Color textColor = AppColors.onPrimary, fontSize = largeHeadlineSize1}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(
          fontFamily: appNameFontFamily,
          color: textColor,
          fontSize: MediaQuery.of(context).textScaleFactor * fontSize),
    );
  }

  Text largeHeadline2(BuildContext context,
      {Color textColor = AppColors.onPrimary, fontSize = largeHeadlineSize2}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(
          fontFamily: appNameFontFamily,
          color: textColor,
          fontSize: MediaQuery.of(context).textScaleFactor * fontSize),
    );
  }

  Text applyColor({Color textColor = AppColors.onPrimary}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(color: textColor),
    );
  }

  Text applyBold(BuildContext context,
      {Color textColor = AppColors.onPrimary, var fontSize = 18.0}) {
    Text text = this;
    return Text(
      text.data ?? "",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: MediaQuery.of(context).textScaleFactor * fontSize),
    );
  }
}

const appNameFontFamily = 'Varta';
const largeHeadLineSize = 50;
const largeHeadlineSize1 = 40;
const largeHeadlineSize2 = 30;
