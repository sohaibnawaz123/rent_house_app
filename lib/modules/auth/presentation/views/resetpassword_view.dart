import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/resetpassword/resetpassword_bloc.dart';


class ResetpasswordView extends StatefulWidget {
  final ResetpasswordBloc bloc;
  const ResetpasswordView({
    super.key,
    required this.bloc,
  });

  @override
  State<ResetpasswordView> createState() => _ResetpasswordViewState();
}

class _ResetpasswordViewState extends State<ResetpasswordView> {
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
