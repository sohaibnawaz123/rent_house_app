import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';

import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network_handler.dart';
import 'package:taxi_app/features/app/data/models/base_json.dart';
import 'package:taxi_app/modules/onboarding/data/datasource/onboarding_remote_data_source.dart';
import 'package:taxi_app/modules/onboarding/data/model/response/onboarding_model/onboarding_model.dart';
import 'package:taxi_app/modules/onboarding/domain/params/onboarding_param.dart';

class OnboardingRemoteDataSourceImpl
    implements OnboardingRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  OnboardingRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<OnboardingModel>>> 
      onboarding(OnboardingParam data) =>
      network
          .get(
            AppUrl.onboardingUrl,
            query: data.toModel().toJson(),
            ApiHeader.json(),
        // authType: AuthType.cookie,
          )
          .then(
            (value) => value.fold(
              (l) => left(RepoFailure(error: l.error)),
              (response) {
                try {
                  return right(
                    BaseJson<OnboardingModel>.fromJson(
                      response.data,
                          OnboardingModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
