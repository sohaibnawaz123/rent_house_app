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

import 'package:taxi_app/modules/googlemap/data/datasource/locationpick_remote_data_source.dart';
import 'package:taxi_app/modules/googlemap/data/datasource/locationpick_remote_data_source_impl.dart';
import 'package:taxi_app/modules/googlemap/data/rest_api/locationpick_rest_api_repo.dart';
import 'package:taxi_app/modules/googlemap/domain/repository/locationpick_repo.dart';
import 'package:taxi_app/modules/googlemap/domain/usecase/locationpick_use_case.dart';
import 'package:taxi_app/modules/googlemap/presentation/blocs/locationpick/locationpick_bloc.dart';
import 'package:taxi_app/modules/googlemap/presentation/routes/locationpick_view_initial_params.dart';

import 'package:taxi_app/modules/googlemap/data/datasource/locationselection_remote_data_source.dart';
import 'package:taxi_app/modules/googlemap/data/datasource/locationselection_remote_data_source_impl.dart';
import 'package:taxi_app/modules/googlemap/data/rest_api/locationselection_rest_api_repo.dart';
import 'package:taxi_app/modules/googlemap/domain/repository/locationselection_repo.dart';
import 'package:taxi_app/modules/googlemap/domain/usecase/locationselection_use_case.dart';
import 'package:taxi_app/modules/googlemap/presentation/blocs/locationselection/locationselection_bloc.dart';
import 'package:taxi_app/modules/googlemap/presentation/routes/locationselection_view_initial_params.dart';

import 'package:taxi_app/modules/dashboard/data/datasource/dashboardroot_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardroot_remote_data_source_impl.dart';
import 'package:taxi_app/modules/dashboard/data/rest_api/dashboardroot_rest_api_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardroot_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardroot_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardroot/dashboardroot_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardroot_view_initial_params.dart';

import 'package:taxi_app/modules/dashboard/data/datasource/dashboardhome_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardhome_remote_data_source_impl.dart';
import 'package:taxi_app/modules/dashboard/data/rest_api/dashboardhome_rest_api_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardhome_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardhome_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardhome/dashboardhome_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardhome_view_initial_params.dart';

import 'package:taxi_app/modules/dashboard/data/datasource/dashboardexplore_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardexplore_remote_data_source_impl.dart';
import 'package:taxi_app/modules/dashboard/data/rest_api/dashboardexplore_rest_api_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardexplore_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardexplore_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardexplore/dashboardexplore_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardexplore_view_initial_params.dart';

import 'package:taxi_app/modules/dashboard/data/datasource/dashboardfavourite_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardfavourite_remote_data_source_impl.dart';
import 'package:taxi_app/modules/dashboard/data/rest_api/dashboardfavourite_rest_api_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardfavourite_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardfavourite_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardfavourite/dashboardfavourite_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardfavourite_view_initial_params.dart';

import 'package:taxi_app/modules/dashboard/data/datasource/dashboardbooking_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardbooking_remote_data_source_impl.dart';
import 'package:taxi_app/modules/dashboard/data/rest_api/dashboardbooking_rest_api_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardbooking_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardbooking_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardbooking/dashboardbooking_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardbooking_view_initial_params.dart';

import 'package:taxi_app/modules/dashboard/data/datasource/dashboardprofile_remote_data_source.dart';
import 'package:taxi_app/modules/dashboard/data/datasource/dashboardprofile_remote_data_source_impl.dart';
import 'package:taxi_app/modules/dashboard/data/rest_api/dashboardprofile_rest_api_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/repository/dashboardprofile_repo.dart';
import 'package:taxi_app/modules/dashboard/domain/usecase/dashboardprofile_use_case.dart';
import 'package:taxi_app/modules/dashboard/presentation/blocs/dashboardprofile/dashboardprofile_bloc.dart';
import 'package:taxi_app/modules/dashboard/presentation/routes/dashboardprofile_view_initial_params.dart';

import 'package:taxi_app/modules/setting/data/datasource/editprofile_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/datasource/editprofile_remote_data_source_impl.dart';
import 'package:taxi_app/modules/setting/data/rest_api/editprofile_rest_api_repo.dart';
import 'package:taxi_app/modules/setting/domain/repository/editprofile_repo.dart';
import 'package:taxi_app/modules/setting/domain/usecase/editprofile_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/editprofile/editprofile_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/routes/editprofile_view_initial_params.dart';

import 'package:taxi_app/modules/setting/data/datasource/payment_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/datasource/payment_remote_data_source_impl.dart';
import 'package:taxi_app/modules/setting/data/rest_api/payment_rest_api_repo.dart';
import 'package:taxi_app/modules/setting/domain/repository/payment_repo.dart';
import 'package:taxi_app/modules/setting/domain/usecase/payment_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/payment/payment_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/routes/payment_view_initial_params.dart';

import 'package:taxi_app/modules/setting/data/datasource/notification_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/datasource/notification_remote_data_source_impl.dart';
import 'package:taxi_app/modules/setting/data/rest_api/notification_rest_api_repo.dart';
import 'package:taxi_app/modules/setting/domain/repository/notification_repo.dart';
import 'package:taxi_app/modules/setting/domain/usecase/notification_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/notification/notification_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/routes/notification_view_initial_params.dart';

import 'package:taxi_app/modules/setting/data/datasource/recent_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/datasource/recent_remote_data_source_impl.dart';
import 'package:taxi_app/modules/setting/data/rest_api/recent_rest_api_repo.dart';
import 'package:taxi_app/modules/setting/domain/repository/recent_repo.dart';
import 'package:taxi_app/modules/setting/domain/usecase/recent_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/recent/recent_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/routes/recent_view_initial_params.dart';

import 'package:taxi_app/modules/setting/data/datasource/about_remote_data_source.dart';
import 'package:taxi_app/modules/setting/data/datasource/about_remote_data_source_impl.dart';
import 'package:taxi_app/modules/setting/data/rest_api/about_rest_api_repo.dart';
import 'package:taxi_app/modules/setting/domain/repository/about_repo.dart';
import 'package:taxi_app/modules/setting/domain/usecase/about_use_case.dart';
import 'package:taxi_app/modules/setting/presentation/blocs/about/about_bloc.dart';
import 'package:taxi_app/modules/setting/presentation/routes/about_view_initial_params.dart';

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
  // <<<<<<<<<<<<<<<<<<<<<<<  Locationpick  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<LocationpickRemoteDataSource>()) {
    getIt.registerSingleton<LocationpickRemoteDataSource>(
      LocationpickRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<LocationpickRepo>()) {
    getIt.registerSingleton<LocationpickRepo>(LocationpickRestApiRepo(getIt()));
  }

  if (!getIt.isRegistered<LocationpickUseCase>()) {
    getIt.registerSingleton<LocationpickUseCase>(LocationpickUseCase(getIt()));
  }

  if (!getIt.isRegistered<LocationpickBloc>()) {
    getIt.registerFactoryParam<
      LocationpickBloc,
      LocationpickViewInitialParams,
      dynamic
    >((params, _) => LocationpickBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Locationselection  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<LocationselectionRemoteDataSource>()) {
    getIt.registerSingleton<LocationselectionRemoteDataSource>(
      LocationselectionRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<LocationselectionRepo>()) {
    getIt.registerSingleton<LocationselectionRepo>(
      LocationselectionRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<LocationselectionUseCase>()) {
    getIt.registerSingleton<LocationselectionUseCase>(
      LocationselectionUseCase(getIt()),
    );
  }

  if (!getIt.isRegistered<LocationselectionBloc>()) {
    getIt.registerFactoryParam<
      LocationselectionBloc,
      LocationselectionViewInitialParams,
      dynamic
    >((params, _) => LocationselectionBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Dashboardroot  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<DashboardrootRemoteDataSource>()) {
    getIt.registerSingleton<DashboardrootRemoteDataSource>(
      DashboardrootRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardrootRepo>()) {
    getIt.registerSingleton<DashboardrootRepo>(
      DashboardrootRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardrootUseCase>()) {
    getIt.registerSingleton<DashboardrootUseCase>(
      DashboardrootUseCase(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardrootBloc>()) {
    getIt.registerFactoryParam<
      DashboardrootBloc,
      DashboardrootViewInitialParams,
      dynamic
    >((params, _) => DashboardrootBloc(params));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Dashboardhome  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<DashboardhomeRemoteDataSource>()) {
    getIt.registerSingleton<DashboardhomeRemoteDataSource>(
      DashboardhomeRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardhomeRepo>()) {
    getIt.registerSingleton<DashboardhomeRepo>(
      DashboardhomeRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardhomeUseCase>()) {
    getIt.registerSingleton<DashboardhomeUseCase>(
      DashboardhomeUseCase(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardhomeBloc>()) {
    getIt.registerFactoryParam<
      DashboardhomeBloc,
      DashboardhomeViewInitialParams,
      dynamic
    >((params, _) => DashboardhomeBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Dashboardexplore  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<DashboardexploreRemoteDataSource>()) {
    getIt.registerSingleton<DashboardexploreRemoteDataSource>(
      DashboardexploreRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardexploreRepo>()) {
    getIt.registerSingleton<DashboardexploreRepo>(
      DashboardexploreRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardexploreUseCase>()) {
    getIt.registerSingleton<DashboardexploreUseCase>(
      DashboardexploreUseCase(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardexploreBloc>()) {
    getIt.registerFactoryParam<
      DashboardexploreBloc,
      DashboardexploreViewInitialParams,
      dynamic
    >((params, _) => DashboardexploreBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Dashboardfavourite  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<DashboardfavouriteRemoteDataSource>()) {
    getIt.registerSingleton<DashboardfavouriteRemoteDataSource>(
      DashboardfavouriteRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardfavouriteRepo>()) {
    getIt.registerSingleton<DashboardfavouriteRepo>(
      DashboardfavouriteRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardfavouriteUseCase>()) {
    getIt.registerSingleton<DashboardfavouriteUseCase>(
      DashboardfavouriteUseCase(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardfavouriteBloc>()) {
    getIt.registerFactoryParam<
      DashboardfavouriteBloc,
      DashboardfavouriteViewInitialParams,
      dynamic
    >((params, _) => DashboardfavouriteBloc(params, getIt()));
  }
  // <<<<<<<<<<<<<<<<<<<<<<<  Dashboardbooking  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<DashboardbookingRemoteDataSource>()) {
    getIt.registerSingleton<DashboardbookingRemoteDataSource>(
      DashboardbookingRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardbookingRepo>()) {
    getIt.registerSingleton<DashboardbookingRepo>(
      DashboardbookingRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardbookingUseCase>()) {
    getIt.registerSingleton<DashboardbookingUseCase>(
      DashboardbookingUseCase(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardbookingBloc>()) {
    getIt.registerFactoryParam<
      DashboardbookingBloc,
      DashboardbookingViewInitialParams,
      dynamic
    >((params, _) => DashboardbookingBloc(params, getIt()));
  }
  // <<<<<<<<<<<<<<<<<<<<<<<  Dashboardprofile  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<DashboardprofileRemoteDataSource>()) {
    getIt.registerSingleton<DashboardprofileRemoteDataSource>(
      DashboardprofileRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardprofileRepo>()) {
    getIt.registerSingleton<DashboardprofileRepo>(
      DashboardprofileRestApiRepo(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardprofileUseCase>()) {
    getIt.registerSingleton<DashboardprofileUseCase>(
      DashboardprofileUseCase(getIt()),
    );
  }

  if (!getIt.isRegistered<DashboardprofileBloc>()) {
    getIt.registerFactoryParam<
      DashboardprofileBloc,
      DashboardprofileViewInitialParams,
      dynamic
    >((params, _) => DashboardprofileBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Editprofile  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<EditprofileRemoteDataSource>()) {
    getIt.registerSingleton<EditprofileRemoteDataSource>(
      EditprofileRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<EditprofileRepo>()) {
    getIt.registerSingleton<EditprofileRepo>(EditprofileRestApiRepo(getIt()));
  }

  if (!getIt.isRegistered<EditprofileUseCase>()) {
    getIt.registerSingleton<EditprofileUseCase>(EditprofileUseCase(getIt()));
  }

  if (!getIt.isRegistered<EditprofileBloc>()) {
    getIt.registerFactoryParam<
      EditprofileBloc,
      EditprofileViewInitialParams,
      dynamic
    >((params, _) => EditprofileBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Payment  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<PaymentRemoteDataSource>()) {
    getIt.registerSingleton<PaymentRemoteDataSource>(
      PaymentRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<PaymentRepo>()) {
    getIt.registerSingleton<PaymentRepo>(PaymentRestApiRepo(getIt()));
  }

  if (!getIt.isRegistered<PaymentUseCase>()) {
    getIt.registerSingleton<PaymentUseCase>(PaymentUseCase(getIt()));
  }

  if (!getIt.isRegistered<PaymentBloc>()) {
    getIt.registerFactoryParam<PaymentBloc, PaymentViewInitialParams, dynamic>(
      (params, _) => PaymentBloc(params, getIt()),
    );
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Notification  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<NotificationRemoteDataSource>()) {
    getIt.registerSingleton<NotificationRemoteDataSource>(
      NotificationRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<NotificationRepo>()) {
    getIt.registerSingleton<NotificationRepo>(NotificationRestApiRepo(getIt()));
  }

  if (!getIt.isRegistered<NotificationUseCase>()) {
    getIt.registerSingleton<NotificationUseCase>(NotificationUseCase(getIt()));
  }

  if (!getIt.isRegistered<NotificationBloc>()) {
    getIt.registerFactoryParam<
      NotificationBloc,
      NotificationViewInitialParams,
      dynamic
    >((params, _) => NotificationBloc(params, getIt()));
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  Recent  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<RecentRemoteDataSource>()) {
    getIt.registerSingleton<RecentRemoteDataSource>(
      RecentRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<RecentRepo>()) {
    getIt.registerSingleton<RecentRepo>(RecentRestApiRepo(getIt()));
  }

  if (!getIt.isRegistered<RecentUseCase>()) {
    getIt.registerSingleton<RecentUseCase>(RecentUseCase(getIt()));
  }

  if (!getIt.isRegistered<RecentBloc>()) {
    getIt.registerFactoryParam<RecentBloc, RecentViewInitialParams, dynamic>(
      (params, _) => RecentBloc(params, getIt()),
    );
  }

  // <<<<<<<<<<<<<<<<<<<<<<<  About  >>>>>>>>>>>>>>>>>>>>>>>
  if (!getIt.isRegistered<AboutRemoteDataSource>()) {
    getIt.registerSingleton<AboutRemoteDataSource>(
      AboutRemoteDataSourceImpl(getIt(), getIt()),
    );
  }

  if (!getIt.isRegistered<AboutRepo>()) {
    getIt.registerSingleton<AboutRepo>(AboutRestApiRepo(getIt()));
  }

  if (!getIt.isRegistered<AboutUseCase>()) {
    getIt.registerSingleton<AboutUseCase>(AboutUseCase(getIt()));
  }

  if (!getIt.isRegistered<AboutBloc>()) {
    getIt.registerFactoryParam<AboutBloc, AboutViewInitialParams, dynamic>(
      (params, _) => AboutBloc(params, getIt()),
    );
  }
}
