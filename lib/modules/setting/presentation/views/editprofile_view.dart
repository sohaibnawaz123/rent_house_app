import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/editprofile/editprofile_bloc.dart';


class EditprofileView extends StatefulWidget {
  final EditprofileBloc bloc;
  const EditprofileView({
    super.key,
    required this.bloc,
  });

  @override
  State<EditprofileView> createState() => _EditprofileViewState();
}

class _EditprofileViewState extends State<EditprofileView> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColor.base,

      
    );
  
  }
}
