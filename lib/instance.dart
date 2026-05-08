import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/network/network.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/onboarding/data/datasource/onboarding_remote_data_source.dart';
import 'package:taxi_app/modules/onboarding/data/datasource/onboarding_remote_data_source_impl.dart';
import 'package:taxi_app/modules/onboarding/data/rest_api/onboarding_rest_api_repo.dart';
import 'package:taxi_app/modules/onboarding/domain/repository/onboarding_repo.dart';
import 'package:taxi_app/modules/onboarding/domain/usecase/onboarding_use_case.dart';
import 'package:taxi_app/modules/onboarding/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:taxi_app/modules/onboarding/presentation/routes/onboarding_view_initial_params.dart';
import 'package:taxi_app/modules/auth/data/datasource/signup_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/datasource/signup_remote_data_source_impl.dart';
import 'package:taxi_app/modules/auth/data/rest_api/signup_rest_api_repo.dart';
import 'package:taxi_app/modules/auth/domain/repository/signup_repo.dart';
import 'package:taxi_app/modules/auth/domain/usecase/signup_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/signup/signup_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/signup_view_initial_params.dart';

void getInstance(BuildContext context) {
  getIt = GetIt.instance;
  if (getIt.isRegistered<Network>()) return;

  getIt.registerSingleton<Network>(NetworkService());
  getIt.registerSingleton<AppUrl>(AppUrl());

  // <<<<<<<<<<<<<<<<<<<<<<<  Onboarding  >>>>>>>>>>>>>>>>>>>>>>>
  getIt.registerSingleton<OnboardingRemoteDataSource>(
    OnboardingRemoteDataSourceImpl(getIt(), getIt()),
  );

  getIt.registerSingleton<OnboardingRepo>(OnboardingRestApiRepo(getIt()));

  getIt.registerSingleton<OnboardingUseCase>(OnboardingUseCase(getIt()));

  getIt.registerFactoryParam<
    OnboardingBloc,
    OnboardingViewInitialParams,
    dynamic
  >((params, _) => OnboardingBloc(params, getIt()));

  // <<<<<<<<<<<<<<<<<<<<<<<  Signup  >>>>>>>>>>>>>>>>>>>>>>>
  getIt.registerSingleton<SignupRemoteDataSource>(
    SignupRemoteDataSourceImpl(getIt(), getIt()),
  );

  getIt.registerSingleton<SignupRepo>(SignupRestApiRepo(getIt()));

  getIt.registerSingleton<SignupUseCase>(SignupUseCase(getIt()));

  getIt.registerFactoryParam<SignupBloc, SignupViewInitialParams, dynamic>(
    (params, _) => SignupBloc(params, getIt()),
  );
}
