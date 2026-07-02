import 'package:fpdart/fpdart.dart';
import 'package:taxi_app/core/constant/app_url.dart';
import 'package:taxi_app/core/failures/repo_failure.dart';
import 'package:taxi_app/core/network/api_header.dart';
import 'package:taxi_app/core/network/network_service.dart';
import 'package:taxi_app/modules/app/data/models/base_json.dart';
import 'package:taxi_app/modules/activity/data/datasource/bookingreviews_remote_data_source.dart';
import 'package:taxi_app/modules/activity/data/model/response/bookingreviews_model/bookingreviews_model.dart';
import 'package:taxi_app/modules/activity/domain/params/bookingreviews_param.dart';

class BookingreviewsRemoteDataSourceImpl
    implements BookingreviewsRemoteDataSource {
  final NetworkService network;
  final AppUrl appUrl;

  BookingreviewsRemoteDataSourceImpl(
    this.network,
    this.appUrl,
  );

  @override
  Future<Either<RepoFailure, BaseJson<BookingreviewsModel>>> 
      bookingreviews(BookingreviewsParam data) =>
      network
          .post(
            AppUrl.bookingreviewsUrl,
             data.toModel().toJson(),
            ApiHeader.json(),
        // authType: AuthType.cookie,

          )
          .then(
            (value) => value.fold(
              (l) => left(RepoFailure(error: l.error)),
              (response) {
                try {
                  return right(
                    BaseJson<BookingreviewsModel>.fromJson(
                      response as Map<String, dynamic>,
                      BookingreviewsModel.fromJson,
                    ),
                  );
                } catch (e) {
                  return left(RepoFailure(error: e.toString()));
                }
              },
            ),
          );
}
