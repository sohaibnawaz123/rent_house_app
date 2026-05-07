import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/network/network.dart';
import 'package:taxi_app/core/network/network_service.dart';
void getInstance(BuildContext context) {
  getIt = GetIt.instance;
  getIt.registerSingleton<Network>(NetworkService());
  getIt.registerSingleton<AppUrl>(AppUrl());

  
}