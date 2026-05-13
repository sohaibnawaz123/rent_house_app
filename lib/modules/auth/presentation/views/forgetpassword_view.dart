import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/forgetpassword/forgetpassword_bloc.dart';


class ForgetpasswordView extends StatefulWidget {
  final ForgetpasswordBloc bloc;
  const ForgetpasswordView({
    super.key,
    required this.bloc,
  });

  @override
  State<ForgetpasswordView> createState() => _ForgetpasswordViewState();
}

class _ForgetpasswordViewState extends State<ForgetpasswordView> {
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
