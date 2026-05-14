import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taxi_app/main.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/onboarding/data/datasource/onboarding_remote_data_source.dart';
import 'package:taxi_app/modules/onboarding/data/datasource/onboarding_remote_data_source_impl.dart';
import 'package:taxi_app/modules/onboarding/data/rest_api/onboarding_rest_api_repo.dart';
import 'package:taxi_app/modules/onboarding/domain/repository/onboarding_repo.dart';
import 'package:taxi_app/modules/onboarding/domain/usecase/onboarding_use_case.dart';
import 'package:taxi_app/modules/onboarding/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:taxi_app/modules/onboarding/presentation/routes/onboarding_view_initial_params.dart';
import 'package:taxi_app/modules/auth/data/datasource/login_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/datasource/login_remote_data_source_impl.dart';
import 'package:taxi_app/modules/auth/data/rest_api/login_rest_api_repo.dart';
import 'package:taxi_app/modules/auth/domain/repository/login_repo.dart';
import 'package:taxi_app/modules/auth/domain/usecase/login_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/login/login_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/login_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/validator/login_validator.dart';

import 'package:taxi_app/modules/auth/data/datasource/forgetpassword_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/datasource/forgetpassword_remote_data_source_impl.dart';
import 'package:taxi_app/modules/auth/data/rest_api/forgetpassword_rest_api_repo.dart';
import 'package:taxi_app/modules/auth/domain/repository/forgetpassword_repo.dart';
import 'package:taxi_app/modules/auth/domain/usecase/forgetpassword_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/forgetpassword/forgetpassword_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/forgetpassword_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/validator/forgetpassword_validator.dart';

import 'package:taxi_app/modules/auth/data/datasource/otpverification_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/datasource/otpverification_remote_data_source_impl.dart';
import 'package:taxi_app/modules/auth/data/rest_api/otpverification_rest_api_repo.dart';
import 'package:taxi_app/modules/auth/domain/repository/otpverification_repo.dart';
import 'package:taxi_app/modules/auth/domain/usecase/otpverification_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/otpverification/otpverification_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/otpverification_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/validator/otpverification_validator.dart';

import 'package:taxi_app/modules/auth/data/datasource/resetpassword_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/datasource/resetpassword_remote_data_source_impl.dart';
import 'package:taxi_app/modules/auth/data/rest_api/resetpassword_rest_api_repo.dart';
import 'package:taxi_app/modules/auth/domain/repository/resetpassword_repo.dart';
import 'package:taxi_app/modules/auth/domain/usecase/resetpassword_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/resetpassword/resetpassword_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/resetpassword_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/validator/resetpassword_validator.dart';

import 'package:taxi_app/modules/auth/data/datasource/register_remote_data_source.dart';
import 'package:taxi_app/modules/auth/data/datasource/register_remote_data_source_impl.dart';
import 'package:taxi_app/modules/auth/data/rest_api/register_rest_api_repo.dart';
import 'package:taxi_app/modules/auth/domain/repository/register_repo.dart';
import 'package:taxi_app/modules/auth/domain/usecase/register_use_case.dart';
import 'package:taxi_app/modules/auth/presentation/blocs/register/register_bloc.dart';
import 'package:taxi_app/modules/auth/presentation/routes/register_view_initial_params.dart';
import 'package:taxi_app/modules/auth/presentation/validator/register_validator.dart';

void getInstance(BuildContext context) {
  getIt = GetIt.instance;

  if (!getIt.isRegistered<NetworkService>()) {
    getIt.registerSingleton<NetworkService>(NetworkService());
  }
  if (!getIt.isRegistered<AppUrl>()) {
    getIt.registerSingleton<AppUrl>(AppUrl());
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Onboarding  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<OnboardingRemoteDataSource>()) {
    getIt.registerSingleton<OnboardingRemoteDataSource>(
      OnboardingRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<OnboardingRepo>()) {
    getIt.registerSingleton<OnboardingRepo>(OnboardingRestApiRepo(getIt()));
  }

  if (!getIt.isRegistered<OnboardingUseCase>()) {
    getIt.registerSingleton<OnboardingUseCase>(OnboardingUseCase(getIt()));
  }

  if (!getIt.isRegistered<OnboardingBloc>()) {
    getIt.registerFactoryParam<
      OnboardingBloc,
      OnboardingViewInitialParams,
      dynamic
    >((params, _) => OnboardingBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Login  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<LoginRemoteDataSource>()) {
    getIt.registerSingleton<LoginRemoteDataSource>(
      LoginRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<LoginValidator>()) {
    getIt.registerSingleton<LoginValidator>(LoginValidator());
  }

  if (!getIt.isRegistered<LoginRepo>()) {
    getIt.registerSingleton<LoginRepo>(LoginRestApiRepo(getIt()));
  }

  if (!getIt.isRegistered<LoginUseCase>()) {
    getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt(), getIt()));
  }

  if (!getIt.isRegistered<LoginBloc>()) {
    getIt.registerFactoryParam<LoginBloc, LoginViewInitialParams, dynamic>(
      (params, _) => LoginBloc(params, getIt()),
    );
  }
  // <<<<<<<<<<<<<<<<<<<<<<<  Forgetpassword  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<ForgetpasswordRemoteDataSource>()) {
    getIt.registerSingleton<ForgetpasswordRemoteDataSource>(
      ForgetpasswordRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<ForgetpasswordValidator>()) {
    getIt.registerSingleton<ForgetpasswordValidator>(ForgetpasswordValidator());
  }

  if (!getIt.isRegistered<ForgetpasswordRepo>()) {
    getIt.registerSingleton<ForgetpasswordRepo>(
      ForgetpasswordRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<ForgetpasswordUseCase>()) {
    getIt.registerSingleton<ForgetpasswordUseCase>(
      ForgetpasswordUseCase(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<ForgetpasswordBloc>()) {
    getIt.registerFactoryParam<
      ForgetpasswordBloc,
      ForgetpasswordViewInitialParams,
      dynamic
    >((params, _) => ForgetpasswordBloc(params, getIt()));
  }
  // <<<<<<<<<<<<<<<<<<<<<<<  Otpverification  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<OtpverificationRemoteDataSource>()) {
    getIt.registerSingleton<OtpverificationRemoteDataSource>(
      OtpverificationRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<OtpverificationValidator>()) {
    getIt.registerSingleton<OtpverificationValidator>(
      OtpverificationValidator(),
    );
  }

  if (!getIt.isRegistered<OtpverificationRepo>()) {
    getIt.registerSingleton<OtpverificationRepo>(
      OtpverificationRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<OtpverificationUseCase>()) {
    getIt.registerSingleton<OtpverificationUseCase>(
      OtpverificationUseCase(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<OtpverificationBloc>()) {
    getIt.registerFactoryParam<
      OtpverificationBloc,
      OtpverificationViewInitialParams,
      dynamic
    >((params, _) => OtpverificationBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Resetpassword  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<ResetpasswordRemoteDataSource>()) {
    getIt.registerSingleton<ResetpasswordRemoteDataSource>(
      ResetpasswordRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<ResetpasswordValidator>()) {
    getIt.registerSingleton<ResetpasswordValidator>(ResetpasswordValidator());
  }

  if (!getIt.isRegistered<ResetpasswordRepo>()) {
    getIt.registerSingleton<ResetpasswordRepo>(
      ResetpasswordRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<ResetpasswordUseCase>()) {
    getIt.registerSingleton<ResetpasswordUseCase>(
      ResetpasswordUseCase(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<ResetpasswordBloc>()) {
    getIt.registerFactoryParam<
      ResetpasswordBloc,
      ResetpasswordViewInitialParams,
      dynamic
    >((params, _) => ResetpasswordBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Register  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<RegisterRemoteDataSource>()) {
    getIt.registerSingleton<RegisterRemoteDataSource>(
      RegisterRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<RegisterValidator>()) {
    getIt.registerSingleton<RegisterValidator>(RegisterValidator());
  }

  if (!getIt.isRegistered<RegisterRepo>()) {
    getIt.registerSingleton<RegisterRepo>(RegisterRestApiRepo(getIt()));
  }

  if (!getIt.isRegistered<RegisterUseCase>()) {
    getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(getIt(), getIt()));
  }

  if (!getIt.isRegistered<RegisterBloc>()) {
    getIt
        .registerFactoryParam<RegisterBloc, RegisterViewInitialParams, dynamic>(
          (params, _) => RegisterBloc(params, getIt()),
        );
  }
}
