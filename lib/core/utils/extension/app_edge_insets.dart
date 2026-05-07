import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AppEdgeInsets on BuildContext {
  EdgeInsets get pagePadding => EdgeInsets.only(
    left: 20,
    right: 20,
    top: MediaQuery.of(this).padding.top + 10.h,
    bottom: MediaQuery.of(this).padding.bottom + 20.h,
  );
  EdgeInsets get pagePaddingTopless =>
      EdgeInsets.only(left: 20, right: 20, bottom: pagePadding.bottom);

  EdgeInsets get sheetPadding => EdgeInsets.only(
    left: pagePadding.left,
    right: pagePadding.right,
    top: 10,
    bottom: pagePadding.bottom,
  );

  EdgeInsets get buttonMargin => EdgeInsets.only(
    left: pagePadding.left,
    right: pagePadding.left,
    bottom: pagePadding.bottom,
  );
  EdgeInsets get buttonMarginTopBottom =>
      EdgeInsets.only(top: 20, bottom: pagePadding.bottom);
}
