import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AppSizedBoxX on num {
  SizedBox get heightBox => SizedBox(height: h);

  SizedBox get widthBox => SizedBox(width: w);
}
