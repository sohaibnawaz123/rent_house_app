import 'package:flutter/material.dart';
import 'package:taxi_app/core/resource/app_color.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/notification/notification_bloc.dart';

class NotificationView extends StatefulWidget {
  final NotificationBloc bloc;
  const NotificationView({super.key, required this.bloc});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
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

